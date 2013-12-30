package org.process
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import org.graphics.B2Graphics;

	public class GProcess
	{
		private var server:ServerSocket;
		private var buffer:String = "";
		private var graphic:B2Graphics = null;
		private var _console:TextField;
		
		public function g():B2Graphics{
			return this.graphic;
		}
		
		
		public function console(line:String):void{
			if(this._console != null){
				this._console.appendText(line);
				_update_console();
			}
		}
		
		private function _update_console():void {
			var tf:TextField= this._console;
			if (!tf) return; 
			tf.scrollV=tf.maxScrollV + 100;
			//trace(tf.maxScrollV);
		}
		
		
		public function GProcess(port:int)
		{
			this.graphic = new B2Graphics(800,800);
			this._console = new TextField();
			this.graphic.addChild(this._console);
			this._console.width = 200;
			try{
				this.server = new ServerSocket();
				this.server.bind(port);
				this.server.addEventListener(ServerSocketConnectEvent.CONNECT,onConnected);
				this.server.listen();
				this.console("listen on:" + port.toString() + "\n");
			}catch(error:Error){
				this.console("err:" + error.message + "\n");
			}
		}
		
		protected function onConnected(e:ServerSocketConnectEvent):void{
			var socket:Socket = e.socket;
			if(socket != null && socket.connected){
			}
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			this.console("socket connected !!!\n");
		}
		
		protected function onData(e:ProgressEvent):void{
			var socket:Socket = e.target as Socket;
			var bytes:ByteArray = new ByteArray();
			socket.readBytes(bytes);
			var tmp:String = "" + bytes;
			tmp = tmp.replace(/^\s+/,"");
			tmp = tmp.replace(/\s+$/,"");
			//trace("recv:" + tmp);
			var n = tmp.indexOf("#");
			if(n == -1){
				buffer += tmp;
			}else{
				if(n == 0){
					buffer = tmp.substr(1,tmp.length);
					if(buffer.length > 0){
						this.onCommand(buffer,socket);
					}
				}else{
					buffer += tmp.substr(0,n);
					this.onCommand(buffer,socket);
					buffer = tmp.substr(n+1,tmp.length);
				}
			}
		}
		
		protected function onCommand(s:String,socket:Socket):void{
			//trace("command:" + s);
			var args:Array = s.split(/\s/);
			var cmd:String = args.shift();
			if(this.graphic.hasOwnProperty(cmd)){
				var func:Function = this.graphic[cmd];
				try{
					func.apply(this.graphic,args);
					if(socket != null && socket.connected){
						//socket.writeUTFBytes(".");
					}
					console("#" + s + "\n");
				}catch(error:Error){
					if(socket != null && socket.connected){
						socket.writeUTFBytes(error.message);
					}
				}
			}
		}
		
		protected function onClosed(e:Event):void{
			trace("socket closed");
			this.console("socket closed \n");
		}
	}
}
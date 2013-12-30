package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import org.process.GProcess;
	
	[SWF(width="800", height="800")]
	public class gss extends Sprite
	{
		private var g:GProcess = null;
		
		public function gss()
		{
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.align = StageAlign.TOP_LEFT;
			this.addEventListener(Event.ADDED_TO_STAGE,this.init);
			g = new GProcess(9001);
			this.addChild(g.g());
		}
		
		protected function init(e:Event):void{
			this.graphics.beginFill(0xffffff);
			this.graphics.lineStyle(0.1,0x000000,0.5,true,"normal");
			for(var i:int=50; i < this.width; i+=50){
				for(var j:int=0; j < this.height; j+=4){
					this.graphics.moveTo(i, j);
					this.graphics.lineTo(i,j+2);
				}
			}
			for(var j:int=50; j < this.height - 50; j+=50){
				for(var i:int=0; i < this.width; i+=4){
					this.graphics.moveTo(i, j);
					this.graphics.lineTo(i+2, j);
				}
			}
			this.graphics.endFill();
		}
	}
}
package game 
{
	
	/**
	 * ...Public Interface For Game Elements
	 * @author Leonid Trofimchuk
	 */
	public interface IGameElement 
	{
		function update():void
		function setPosition(x:int = 0, y:int = 0):void
	}
	
}
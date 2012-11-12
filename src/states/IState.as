package states 
{
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public interface IState 
	{
		function enterState():void;
		
		function leaveState():void;
	}
}
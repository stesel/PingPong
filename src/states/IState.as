package states 
{
	/**
	 * ...Public Interface for State Engine
	 * @author Leonid Trofimchuk
	 */
	public interface IState 
	{
		function enterState():void;
		
		function leaveState():void;
	}
}
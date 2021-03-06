package strategy1.step4.modularization;
//4단계 : 기능을 부품화
public class TestMain {
	public static void main(String[] args) {
		Robot superR = new SuperRobot();
		Robot standR = new StandardRobot();
		Robot lowR = new LowRobot();
		Robot[] robots = { superR, standR, lowR };
		for(Robot robot : robots) {
			robot.shape();
			robot.actionWalk();
			robot.actionRun();
			robot.actionFly();
			robot.actionMissile();
			robot.actionKnife();
		}
		//lowR.setFly(new FlyYes());
	}
}

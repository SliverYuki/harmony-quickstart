import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 应用初始化
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');

    // 创建 eventHub 事件发布订阅
    const eventHub = this.context.eventHub
    eventHub.on('TabSwitch', (index: number) => {
      hilog.info(DOMAIN, 'testTag', '%{public}s', 'Switch Tab')
    })
  }

  onDestroy(): void {
    // 关闭任务，此时机处理保存数据，彻底释放资源等任务，并且在此之后 Ability 实例会被销毁
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // 应用启动，主窗口创建，在此时机必须指定启动的页面，否则会白屏
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // 切换到前台，在此时机处理申请前台运行需要的资源或重新加载在 onBackground 时保存的数据
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // 切换到后台，在此时机处理保存数据，释放后台运行时不需要的资源等操作
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
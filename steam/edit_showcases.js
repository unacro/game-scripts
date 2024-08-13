function SetShowcaseConfig(...args) {
	// https://steamcommunity.com/id/{steam_id}/edit/showcases
	throw new Error("Not Implemented");
}

function simulateSetShowcaseConfig(showcaseId, _, index, { appid }) {
	const showcaseMap = {
		2: "游戏收藏家",
		6: "最喜爱的游戏",
	};
	return new Promise((resolve) => {
		setTimeout(() => {
			resolve(
				`已将第 ${index + 1} 个 <${showcaseMap[showcaseId]}> 展柜设置为 ${appid}`,
			);
		}, 1000);
	});
}

function editShowcases(appIdList, useAsync = true) {
	if (useAsync) {
		Promise.all(
			appIdList.map((appId, index) =>
				simulateSetShowcaseConfig(2, "0", index, { appid: appId }),
			),
		)
			.then((results) => {
				console.info(`<游戏收藏家> 展柜全部设置完成:\n${results.join("\n")}`);
			})
			.catch((error) => {
				console.error("设置失败", error);
			});
	} else {
		const delay = async (delayMillisecond) =>
			await new Promise((resolve) => setTimeout(resolve, delayMillisecond));
		appIdList.reduce(async (promiseChain, appId, index) => {
			await promiseChain;
			const result = simulateSetShowcaseConfig(2, "0", index, { appid: appId });
			console.info(`已将第 ${index + 1} 个展柜设置为 ${appId}`, result);
			return delay(500);
		}, Promise.resolve());
	}
}

const appList = [
	// 怪东西
	// 753, // Steam
	// 765, // Greenlight
	// 766, // Steam Workshop

	// 什么新游戏 比游戏还好康
	2358720, // 黑神话：悟空
	2246340, // Monster Hunter Wilds
	1295660, // 席德·梅尔的文明®VII
	2183900, // Warhammer 40,000: Space Marine 2

	// 直播工具
	1905180, // OBS Studio

	// 好玩 爱玩
	2162800, // 异形工厂2
	2914150, // 晕晕电波症候群
	2868840, // Slay the Spire 2
	// 2322010, // God of War Ragnarök

	// 游戏开发
	404790, // Godot Engine
	1096900, // RPG Maker MZ
	// 363890, // RPG Maker MV
	431730, // Aseprite
	365670, // Blender

	// 联机
	// 1329410, // 雀魂麻將(MahjongSoul)
	// 1449850, // Yu-Gi-Oh! Master Duel
	// 105600, // Terraria
	// 322330, // 饥荒联机版
	// 413150, // Stardew Valley
	// 1243830, // 胡闹厨房 全都好吃
	// 1245620, // 艾尔登法环
	// 1086940, // Baldur's Gate 3
	// 271590, // Grand Theft Auto V
	// 1174180, // Red Dead Redemption 2

	// 艺术品
	// 753640, // Outer Wilds
	// 632470, // Disco Elysium
	// 813230, // ANIMAL WELL
	// 1190460, // DEATH STRANDING
	// 1850570, // DEATH STRANDING DIRECTOR'S CUT
	// 501300, // What Remains of Edith Finch
	// 303210, // The Beginner's Guide (The Stanley Parable author's another game)
].slice(0, 12);
console.log("appIdList =>", appList);
console.log("simulateSetShowcaseConfig() => SetShowcaseConfig()");
editShowcases(appList);

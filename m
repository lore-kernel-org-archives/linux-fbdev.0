Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018D51813A;
	Mon, 21 Sep 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028139; cv=fail; b=DltIKgcmBcQqr967YzjUnz2bdOOEzCFAFmVeKRK9y5TB1DYNuyjmBlcqlWf1i7iiXvlXSlVU5+RF1hzMhUoAi3doBW9Y+O3XxRdjwaSOaIAuIZEt14jR+3QI3N0tVN+YKRqu0kV/AH7WX5nGAlyv2xWagcaZa4SCzPtNvKa4PoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028139; c=relaxed/simple;
	bh=R5Zx5UP2xIRPOyy0OXapoAPspuUpDs2kPte//JWe3O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWjaY1GXfhvsRlfeFR9MFdfPUfwCaGSNAt9453JJqoAcykF00djTdjr6AhpgXoewLWM7NEFp3SPC01gFnlVnRJuZH//6BhGcHFct6g42/yRqLRnnNokii5RJMXfNfdx5lN5XJ3rSm5JQrO/OC3zvH26IqBK+UbChnC0ihT9OezU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZUJ0zda; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZUJ0zda"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzWOj4nioa02IUeIoBcsiVbNJ3VwFoevuGXs7ufrNlSZIkeDSy7XOn6p7BmWlbEW1JBxmLvM8Drd+EQVQxM3yNQBvLPg7uv+MkfvIkpBWo6mskuPL/rSQCk3XUWURprd3SRwB1coyRl++nmKO3UCEf5y2ctpnv8wR4xE+1BP5MSB6ZEKDGIPZTqEGd3NQCLhyvAYmY8hwc8Yty4EGzdnH24FhqdVn7Ou2yg9fS48J5WGBqApIHWc+dYmE+LPVEGKYfaDyQT43eyHQqjQXm8BNAKATcwhbfNGK/vLZz//W7ttNI1j4IIEHD+GD6z1lAdgC99u0E/JPz210Ysr4q3IrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIsY3P9pXrWyESUdvHXPJV8L9IlYB5o6HTWVCOxBPec=;
 b=IHUmtfBonDlls2eQHUEn+E26xxqjmmef+VEPx9UyY7IGlrerUK7onp7xgK6oROU8SK+j2xboC29NUAHdMCwFYldIJkC82xdG5hF5HU0w46iJUjxTnw+IKmMB26nHpfTBCQ8yQXtrBV+8RHfUX/WpGYvmDd4y+bcIvtLt7CbgrOp+y0t/DynO5OVrNG7FihKUe1xcRWcUXq1j1Hxcl6AAuUAA3FEGTmzXzYz63T9hhu1xRON3j/SL1LaQMp7rCFybErYuVlsegMAP+RdhgqAii1j0MbYRlUtKIASwSb1UG3tCgNO8xxCf5TZkpDeYx0gnMAF+7tBk/9rHTztslOHkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIsY3P9pXrWyESUdvHXPJV8L9IlYB5o6HTWVCOxBPec=;
 b=lZUJ0zdaHicwdHU3dqv3ma9Sxgbb8NihpG9eXspyUbPg1P5Mn5kRgfiVAPazNTY4Xe2D9wAh4+sHBDwjceHxc9U+09dKi7b7D8QHMtzIHxAzTK1WrBW76JK3Ovuu6dAIRC8b+fMiKS8qWncyWGfB0LP84jL4/yOCV01dg5RbNY0=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 22:02:13 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::1c) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 22:02:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 22:02:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 17:01:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 17:01:50 -0500
Received: from [10.254.92.51] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 17:01:48 -0500
Message-ID: <8dbfd32d-547c-4b38-b3b3-460c4b666a72@amd.com>
Date: Mon, 21 Sep 2026 18:01:43 -0400
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya
 Kumar" <chaitanya.kumar.borah@intel.com>, Daniel Stone
	<daniels@collabora.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Andrzej Hajda
	<andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	"Robert Foss" <rfoss@kernel.org>, Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
	<andy.yan@rock-chips.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-fbdev@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>, Derek Foreman
	<derek.foreman@collabora.com>, <wayland-devel@lists.freedesktop.org>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7a7293-aed9-43ea-5711-08df182bfdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|42112799006|376014|82310400026|23010399003|36860700016|921020|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nv1FHu48KGmcV7evD5BGx88lYN73sAsLwLRXWyqcsaAwdHyykA37roWT8R0oHy/UnYp+kHHrRMKXJ4Dej/661D+yoe6umVts7KnJETnbzmbyP5PnxWCgJztAsEavBmZagNeRKU7dsFDMcUx49EiEhQ6GgvrvvyCnuUeULDzre/1bWr9v3sK3n6XIAQvakx6AfROt7IwiCrXtf0auQq6HicqCEIwhTcfsTcVunBV3Xz3ffkwsaQP2jnaRp12ptlf5U9ZBDd33V9BhtgppQnccOzoGti3LsSvhB7sBduLaTOpmMC1YG9uTbdAEMlXOZOtvIexzuOlp1vSRj5Yvuda2rJjj6HWrYycN0uKXREvTV5k7j19tQNd3+AGhCZ+kd5O9vV5vVmAoHM85q81LefPFEVYZoqVY7ire+Of+OnJzI8WsOJVYHwU58ZQCC9vPQygi9Zu1LE5NtAOcBa/jgU6PzWxpLJb5dOc9fYdiOjS+AG7/Ms1DfnNF43E698j90eo4qbdxfJzvZmJSBlCxHJuqWf5F52n4ywmekuL5P+niruJhF08r89RYbzKxMIRG5LgkqBx9q+QdfiXN/etdYp5zpd979y+Gd84jXsKIMyM+sa35tQGoj6Pbn1glnbI8pnLw13K5Td0rRXbSLKR2tVYYGLUlh5xvUfhPrDbPHzO88oyWvFxvYRMzFoaK15D3PKyRjO7L5iVQluLJYEF26KNI2jBmLyuI5eJY2OO9p58DuFSLHfpkLhWYueL0mA/HyzC3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(42112799006)(376014)(82310400026)(23010399003)(36860700016)(921020)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OGZIcnmE6jmUPw4Htb01gzEQi6qShUCr4lbW64bMq2Nxd787Y2jEX3eGLIaj1nceqlL1AM41hFN4+ezBMWeadb0zooPxXhUxcp6O/HLPXAVC2WJCjcrfBOfE7uyhC70+pXtvOlYlPhlB3YPIlnEaQhFIkOLn/9t3Tl9PDF+htLbMG1NkOIRLlx5nx4QACEsTEk1dMoivcfHtzYlQ2oDMKJI666J84YSnXAO9l0vnUz1ASTvVyxKc7Ib9fxRzVpwHJQkIkcUkWIqzz1OEiRzIH4OyCF4WRDlLyFLjFPNEoS9K4Ow0zDMaCmUaABqLab0xW3z9gpEaPm+9/2YGX7NI967OYizv/6+LCmhJmkk+MgobJwi29QoDtW3wHNvB1BCR6Ochu5turjc/7oaBAu2+oUvbzOm02YYzyd4yLwecrAsdTVjIZF2jmW0kdsJPG684
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 22:02:12.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7a7293-aed9-43ea-5711-08df182bfdca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

Hi Nicolas,

Thanks for sending this out. I'm looking into an amdgpu implementation
and had some comments along the way. Will reply inline on respective
patches.

On 2026-09-21 11:51, Nicolas Frattaroli wrote:
> A change in whether VRR is enabled or not on a CRTC will be of interest
> to any VRR implementation, as they may need to recalculate certain
> internal state in response. So far, this was handled ad-hoc in the
> drivers that implement VRR.
> 
> Handle this in the common DRM atomic core by setting the mode_changed
> flag when this occurs. The rationale for using mode_changed is that VRR
> is deeply intertwined with the current mode with regards to its timing.
> Consequently, any component that cares about a mode change is likely
> also going to care about VRR being enabled/disabled.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 9d006f98413a..0664d5779282 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -694,6 +694,12 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  			new_crtc_state->active_changed = true;
>  		}
>  
> +		if (old_crtc_state->vrr_enabled != new_crtc_state->vrr_enabled) {
> +			drm_dbg_atomic(dev, "[CRTC:%d:%s] VRR changed\n",
> +				       crtc->base.id, crtc->name);
> +			new_crtc_state->mode_changed = true;
> +		}
> +

I don't think this is the case for all vendors, at least not for amdgpu.
The parts in HW that adjust vtotal can be programmed without requiring
bandwidth recalculations or reprogramming of pipes. 

- Leo

>  		if (new_crtc_state->enable != has_connectors) {
>  			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)\n",
>  				       crtc->base.id, crtc->name,
> 


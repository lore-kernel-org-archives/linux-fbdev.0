Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984964;
	b=X7pI1LlGdotE2k1YQezJ8+0u9P4ma1sxYgat285I0L/0V5BqmuEak6vnG2FwuEUAO8Qp
	 1JhLo6ytgJUB1gZHAqzY3U7YkY/uVLJVMYAasEq33lrmFxRccj84O2H2NzFqAux00lczm
	 cd4jwU1Aa1lqm+Q2QvKFHmpHG/G5gvFWxOpdBFWTkDXVr1LYm98Ri4hvzfQsv4zuadPjS
	 LgfD+JXoMhWAoBQ8ry3Kf1z3EnQ1gQcp8OxBa8SERo4bpCpPrA4d/73JCBaGpRM8w48+4
	 XdZCyAVJBMK3ANccD7nbTxW3j5oxITbxgukHt83y/q8lTRiSnXhqtCVnczkfTKslocg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984964;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r+OQNVaBGZoh30028ZIRIrpjO9cRrUuo+bmNMdd+QDI=;
	b=SMfSZYOJ19n72eyZHEn2P8z60jPwqxLrHE926FAhgKX3YYjyXNo7pJn7tJvRsm4//Y6E
	 3GajMTOAZZ3dJ8ILjqYigAP9KEL2LNWxT5DNP/zC6DRybxCyQOA2Mu+R+4Irt9nkf/U9j
	 eAH7j5P2lOk2pNMSNtA7IK8y0+8u42KVR0pq2K/79+Q3AjF8vFpvqQ+O8DrZ7csxMqHI6
	 HfD7Dh+hiO5UIBAdTjmfHvMm7MrZKD8N1UMyn5ROgO9TM70QGxJXVM7pXwXMnBykSwFPs
	 aDdRWpMj5iRDOoy8a1lQ72bSHPTjaaFLJgb7raLwrRvEYMVUV3/KfrZu0vUH33IjXsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KBNjfHpO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B4606A326;
	Fri,  6 Nov 2026 17:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 085B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KBNjfHpO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWrGJhTxM6xkW7V2bJny7wOLCdATqLUim3HDtEa0tAyBhW4MvYOuem2ptgJws4di8AIkIQK1eO1R01F7iM0XZ5GmW54azXbw/gPGl2JrfAXLi39TlsiLKMqC/eUFCfdBdVXpsR6URE2jEhF50vxOIgDmxawpiMqpb+SAdI8KyglbIMwdQ8ik1QoZMeZHHBhHrTAoXeUmY5kfJ/8DlB+l4teTNN8fuoDlkU0m3IrUQrlQgphCTVgJVdSLbAXG21AUNi9knSb0uVH0N2KBsQyYaZMIZ0stv5+TDtYwoaYSbMEyqNSRlE7CkdmbzdPwLd95Ux215ARpINgghnxEQzemrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+OQNVaBGZoh30028ZIRIrpjO9cRrUuo+bmNMdd+QDI=;
 b=iriLrVWcVEPCT3v1L2/HNXkj71/nlqckZQLRwVofkU55jw/KH3l9K+V4ETKlDKNMnN4BLhvdmR1CQyiC5pAeH2Xk5uNgYcvy+MxLacufxJw1qWOZfh+A3UpHDDx9UC4JG3NGda39JQYSOIaTsXmQZ+VJuTW4Dd+lAd0h1nVBbb1EUNMHlgdMrUrqS9k01/Jqr4j80XdEUfRaYot5spY+/G3WwhmwoqnDrMyz8fIZWQteLMjFHGo3+vKMfvmXZDXA9cw9qSGNBaNacYalldFcBu7WilCVBjWvGDKuk2goyjtzYKwzpwJj1esJjIUaIw+YIS4Y2/H5AiYq5tEi57lyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+OQNVaBGZoh30028ZIRIrpjO9cRrUuo+bmNMdd+QDI=;
 b=KBNjfHpO+Q58hYE3ADT25rQrK0ZMyvJgE88b1HUEyDifA1jNLrVRLhsuj6O4yQtIcbWMqDSFTEGwPHRM3zGtS6JqfRTJc/vxOeFW2HyEvWNx/9Q9Frkte660ZtEtdnWp/w8j2H9cXeSM5fiD6omfW7LinpBPbkBXTcx4VjRmZf4=
Received: from CH0PR03CA0079.namprd03.prod.outlook.com (2603:10b6:610:cc::24)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:09:19 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::9c) by CH0PR03CA0079.outlook.office365.com
 (2603:10b6:610:cc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:09:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:09:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 11:09:16 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 11:09:13 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <deller@gmx.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 0/2] fbdev: remove the Xilinx framebuffer driver
Date: Fri, 6 Nov 2026 22:39:00 +0530
Message-ID: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 4120d1aa-9d67-422a-61e8-08df3c28b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261026121527099003|5023799004|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z7B6o9lVIJWm5jVN2ZEd6s+x9Z437SEeKZpxeUy64SHFfSNnZx8PIjuU+U5phjgkfKW/dMIYTnthaH2bcsENamy4IHYqcq4j7VanLHSBjTn0yoSGcPcU+vKDxrNrFNwAVD7fwgyqKUnub3r4a+dE2gGcEzyradZCvdUpPjykegqIpiBCAmL8AKYs9rsXx2w4hg4J3iwsa/hZ+M7e6NQ24L2+WdZEiZmKvE9xMSKQA73HUKTpzbZA/NSlnH1+faHn9MRIpoTOAfh2DJUrHmJdfhkz2uPwBgBKHbmCczxWtzdz+4y7M05yjKGZy1h2IKtmxT2ZebmYTw0DJTgh3/JMdsF8niDoEyTTxM7QWtJ0q1um49aGy4frhdB+HFG0oaT+7ZT9NdKKMeO4xC2YPElnLo0RjaY6t7Oai1YL9tlHeCOpR0x3vPBkEa++IehU+VNhcfWVQRvjsJsDNx3oMP9b89bomvcDmF/9wMF/lKQC9iBCS2w81XYb5eFUwGr9sFi5GsBSq6iDxLtK6gGbQZtG11BwnIE+gzadnjIdRMCMWtix9pYGX/jS3LRQgd81cSG/4X9a2y9T7k1MAVfJ82Y5A+geqWxUbCIJljD2//w4ur2n2DB2j/CWalHYLXy67/ysNYitRYpVY9pUT5up/nEKXD18w3fDqWmWwG5DfjX5yWYyNRVGcr+86G590Sditevlow+0/2EiIoKmZ7wnUZ+4ZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qpZP10ywsCnsksp4lxcGQqJSQmwor94lF9jDwlGAuzkY0Y/W28jNEE9x2q3D0Zasi3//lOXtPoiSJN84CcP8466+UUCk5oXxaFGyF+IWH5Env4viJu8lPFz/z6HQaeZ9ckVLwlzQAwfu+EL7aU4EZVCvo/JTpQnVhI1Blgo16/03okhCdVUJkTYLlMZ4PAqg7DE55nYUlZL1SYTcwmzhuHwGDtTmGit8UW9rEqIykDzm+qW6uE0/ulkTYHSVJntEE9BKLGI0AjwdixZ6xKZ4lIJv3QT/LrDg9Y6RJoYvBfu8ajUaB28XK00nrQMDVYfvIb3kBuAyTsyv0TB18Xk3qL71AlipwZQJ1tU6u5vbQQQmnL8Q/9GG5AOlzJduNvKCyCiusgoeTIp5gspTjvZmzPEwY41gCS+W6oEYaIcHdDA/E7/sSibMxbmalrpfxGby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:09:18.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4120d1aa-9d67-422a-61e8-08df3c28b1c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926

The Xilinx framebuffer is legacy soft IP for the ML300 and ML403 reference
designs, built with the long discontinued Xilinx Platform Studio and ISE
Design Suite. Nothing upstream carries any of its five compatible strings.
Patch 1 removes the driver, patch 2 its documentation in 
bindings/xilinx.txt. 


Radhey Shyam Pandey (2):
  fbdev: xilinxfb: remove the driver
  dt-bindings: xilinx: Remove description for framebuffer IP

 Documentation/devicetree/bindings/xilinx.txt |  13 -
 drivers/video/fbdev/Kconfig                  |   9 -
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/xilinxfb.c               | 502 -------------------
 4 files changed, 525 deletions(-)
 delete mode 100644 drivers/video/fbdev/xilinxfb.c


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.44.4


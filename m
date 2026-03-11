Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43319367F2E;
	Wed, 11 Mar 2026 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189647; cv=fail; b=jgQwnjdiRKBbXHcWwUDy+4EIhBTQdQ25Qh8IyuO1YQXCN7VUiqCNW0P1KppB+Bu5BquxKth1sJC96kVPQuKZnqHYrB0AP1YjLZFV11VgDBn5mIW2PDtC4pEoNc3i1CGLYNOaDoJd6k8gievrdjYYFxr17EYO1qniZBiEwRnhURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189647; c=relaxed/simple;
	bh=n1hqeGjbdx5mSIk4s+W7Nrr/aMPkJT1rKKGQRkTEh4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXGrsq2WSYR2LmnlyHUlTufp1ZgKiavTyqwXvnRuyLvH9bjcqz9GZWkEbkHczOCdlNAWtr8WnUgLReWVy+CyK864UmAmGwm1kOvB6vWJzpU3RQ5EjO7EGVFht01oXVHNDqXuLqwF+yRXj7zYBjqvpFxlJjjHQpZAyyA2tLfoZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fArgGDtz; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fArgGDtz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc4QRJ0bqwPX456EHMEm5kn/Moi+8CnKTZ6YTOvI7HRRxdNqhlE1HLSmi/I8NdYQsHd4pGWgwRySFWjemanAW0v1RDq4CXIcm6W4X6Bt8bJbGeuDNSNAMAI8Dfl/IryGuHLvTmjoBYG1bG2uE+nlwPweQIi3Qax97pNtHEk5MXGQE1EbVJ88X2FkWlemZlN3GFbnLFU2S7JV0WKVUsAJVyjH6vicsOtKrGCHnpysRF3vOOJrrF8DvONsqIxlRzJOAn+FdYsVqE/H42MMWIjZhuwenZfytCUmruMCpL3LxNOxbNvyWCsIB7sqssDArxKATXOiP+ag3Io3yk4t8j29ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F49cACl3HIGmeiyHiHJIq2FrsVqFrqeo3rTN1RQXi6c=;
 b=aP6HzgHLjjiihnj8zXJ+qAfgKJAAlZkS+VgxLDpqJbFBBmxZ3pquuUl19g+EUkQ5qGPaT5dR7r2g98pTSUhfVRE4x/NtB09RmxIsTaLUxfcB0rKvFUtMUsybO8XwaclDBaXIPJwM3yjwwdZVzikJ5dV/uAcHjOfNuK74ePX4hAWzpMFOZeJeWbwcr56Jv7AmcdTjXN0+cZuTA7ZBp1xdI9vEZscUId+KFbkuwTE7GGlQfDOsX+1A9SxyjCjVYgC2XPfhdd/Scwt2G5C7SiKTV67HruhQn7irliM8VkddB6gN/b+CQc1MN61pLWP66lmON/9QZcgiDVa3GjAVrpzyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F49cACl3HIGmeiyHiHJIq2FrsVqFrqeo3rTN1RQXi6c=;
 b=fArgGDtzLoPYUQJdzZ9AbSBwDu9sIBSOjktBJlcIfrNeYwD7NZAjVukyqvh7Wnt51/zi2MyVr0QGcY91aHghFb0sDM2QgrkmFGe1b/x0x2+H8K33hmYR/9nAi7RbEl+89D5hbVl0atE0CYelehX+uELMHi4Hi7ovx1ZeefddrPE1LgztE6TU0Nb/6aFNzGgXYQCcSy5y4aCqFDFZ/I4eXu+hu5updErVZLOfnhgHHfvu0HXqEJ+4uow0dY7UQvaBcCJQ9VYDqaENRKRHjTS/GeosFI4W7Mdmt6mGBIZsVsRTQW/xnyK+a9ITo+9hA/ELU19ciX8/TfJyAadKUQOeZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 00:40:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:40:34 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Koen Koning <koen.koning@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Nikola Djukic <ndjukic@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Helge Deller <deller@gmx.de>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Edwin Peer <epeer@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Andy Ritger <aritger@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	alexeyi@nvidia.com,
	Eliot Courtney <ecourtney@nvidia.com>,
	joel@joelfernandes.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v9 07/23] docs: gpu: nova-core: Document the PRAMIN aperture mechanism
Date: Tue, 10 Mar 2026 20:39:52 -0400
Message-Id: <20260311004008.2208806-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311004008.2208806-1-joelagnelf@nvidia.com>
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c3df70-ac8f-4fce-c13a-08de7f06ce23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2pIQb0mNDdOUY1ebS4shgRryLOnvd1omdyYFo6h65P9aEF0xkbLeHfq/IWX2q0F1UsTPvn9MMD9EVKOCHbQzsSLej/CHd08O2maH0WX10STl95PnTC018RPuD/cH76Ct2VotVLbXQogFl0xIgx7s66rUxHzTDcVHcTi6x7grrnA6F6jLaLkvHHESnQ3ajWvFFSwqh0gNJNCRZ/l3SUxLuDT0uET3PDkMeTcFPkfppjSzWUQBp5eBGB3iNUf/QyeaHACFKBba8Xj6hjbSffbrMGVoTZsswUUeeH8YPZZnAgDvQGmrCIsrgBGAwRUp6fp0+DSZI/mb937rhynVY2+Y9JWgqkt+L0Nnh++63wn2voxFaZjxNLKKUNwOqL0L1pwEaCmXuMOiWyGm/Tn1ks1/i6Ac5gi7kbfgGmALfL/Um4ENuUW/WfMXt8BDrrj1+s6JaMVo1it3tL60KL4VwSsOMklX0COsEUDBm9rIfOWeWiO0dwRGwPiWlyID1c6JdupLH2ZGxFSwKxupE9b4mpWneANyk/kaSbfQ9QDTVMP6r5B9GEpVJBovWryb31EHMwe28/0Dde/2OjkCSTSPaxoy9kZp1aq+DxVpVn11tnIh1iNQsEDR4fLjCba0sMNjADEVgPmHXFO6KxjKYVxKkec38h4Y06XZFVmRVD9jzTtsHk/wslGsjMebpopfkSzcf0eXykh8Oh8EFDckWQbkWGPsi9yrp9iHMcfuhhICPL3Uh1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9s+aPobUf8tultX4UZCjNchNasLqQfTcSYJy3Y6GmhYoDa5Z0wngt9pmpexz?=
 =?us-ascii?Q?Jsb+Hk6ONNm61cbT9BAxF6P/ZN6O6EbjJxEPLvHJQ/SMe3yeiBH2dAV4FFDe?=
 =?us-ascii?Q?ydCEParPpGOu9EPucD/0hMvlm9WYG/aIGE/mQ1tqPY+2rKebh6CO/41oIoa8?=
 =?us-ascii?Q?CItKHReWhdG2LxVA8yMUo2qN47xrdAD9ZfsVJNiabUQq4njHyD1Sj3ZLpqKV?=
 =?us-ascii?Q?NeTpN92/CvuxA8EIzzVq/P/jML3jlauXPfQ0vAEUsG6PpdCiEsaIwlQHP7HV?=
 =?us-ascii?Q?KiN78EBL75uAC2JVyAiF/nH+UsAYC+eRlWOYcHKpjVDev8bjip+3T80eIDJj?=
 =?us-ascii?Q?aTD/weeFgY0Bdy4Omk0qJyybZbZOfY1cmQU8305X5hUi8r3MmmsZc9l2x4dN?=
 =?us-ascii?Q?fZouGioQ8dEXaoYabQi6sJxWxK1H704GKt5vR7YLd0gZVWLSXl4s7T6HOj/d?=
 =?us-ascii?Q?2pl4/gUjQ2foAaD3Stvpo8jKej0OSv7SEc522XpEme4WhFCTrBHqGDOwoJ/8?=
 =?us-ascii?Q?ayVkBVI5Oqb5FR26C9XdpIQFpWYk8ZDmXSQAbzYCsGaom7UK0+uXUbUDALK7?=
 =?us-ascii?Q?RJkxmma0Km9Of4qHZain3UthfzVRmu+kbWZ+6l4RArXI2A1f4Q4RGGdS7iX9?=
 =?us-ascii?Q?uoDN0fh4gr12MsyGrS3va1k+KCpc9WcjuDxx4h2wEf+P+g28v+a7wYRyoWzC?=
 =?us-ascii?Q?R+jUSmNWFqT3w8XAVvi+3o1PYbBj8qW06DGt8nOVoA8vAdIpXtA+hpNEhJ45?=
 =?us-ascii?Q?AUTXhlca4gKzf1WRBbQTyXbaKc8PBdyvI+r00G8houLZ9xRahD7VHLCyQPZW?=
 =?us-ascii?Q?xpWZRg/cclej5RnhV1fhT3wnGYFFa7sZiLEGFGcCC/ksJFVntSEp1wNd6GWq?=
 =?us-ascii?Q?FOSnyn/q1e5rEcFEoSEBoKLjGuR5GrxrPEP8Uyfh8NGluBX9Sz9o/02X/Kv5?=
 =?us-ascii?Q?vNuB05puoHYYr7ojjLdqBt4pgrudy/CJQVc6UQNLecHEciguthAXaDQg/c+B?=
 =?us-ascii?Q?YU/EecFrZ0kd+G4MtPft98nT/9MIr3uK3OXrpuJ5Ee9HyUly2zctf0WWZBNb?=
 =?us-ascii?Q?bWgvO3uG1/PUdVi0AcMCebq/QHR+VgKruZeSG9+QmBsIzPk34aVtTZAyAkCk?=
 =?us-ascii?Q?d9Qkk4//ddDaA0mZqbeqsVZZnQfkyKpICnGgihuAV0WdSp9gsSEzERIZf4G9?=
 =?us-ascii?Q?guuySKn/Liz3V6zdDxQnE0DMnLaBTlaUC07I3ES03zQsB3S+WVJncHbb+Gxb?=
 =?us-ascii?Q?+NHPRy9Ij0CaZC5F8aiKgVftk3g8K8eEnyBEHlWll9CPQv2g2D3Fl7XBcdrn?=
 =?us-ascii?Q?HlCgUzNV+FSYkI+eS5Lk1DTfavq3m96+ktV9URKqFahLx2RXVdQ2tFI0HZC1?=
 =?us-ascii?Q?SpBmcZfnh5FzHbY/1FtJhYz91At2E+JA4Mo86jxeZUH/9a2iU6hP4zGJb2Rm?=
 =?us-ascii?Q?T6BMisIY4vzAhKVyHDj8yLNrlkZGaxSbw2wRMLDS810eOGyST2qKTbNUJ21t?=
 =?us-ascii?Q?TuhaWgTcOzqwhT8tzSIQA0uyCy7Rig+LHarbo4LKEkU/1EMu4XMzOrbbEJdF?=
 =?us-ascii?Q?4NetrrMzZOQFjMT3LQ0wlZkli93mvlGuvUFDSCE9uO8FU1YhahtzkProlx2W?=
 =?us-ascii?Q?hiVwXusHpbvVbwG1AIExl8kcJt+fRryapqpt48806tGdYPoI1TXMf/35rAtd?=
 =?us-ascii?Q?hRS/6IJa1wwJ+IAHdXG40YDlvphlqQRQbMijTUWxsEjrbDD1Pes9CnUE7nPW?=
 =?us-ascii?Q?pST3RnanwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c3df70-ac8f-4fce-c13a-08de7f06ce23
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:40:33.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+MlvbmXrFfOlYR1tTej3kHQWrE7Oj7eM6QDTJldd1HQsTZ+0wnbVAGId99CaZO8EyTp0dvYT7S/a8CJKKwc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VID_MEM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 125 +++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/gpu/nova/core/pramin.rst

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..55ec9d920629
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere family.
+   It may change for future generations and is intended to assist in understanding
+   the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video RAM (VRAM) before
+the GPU's Memory Management Unit (MMU) and page tables are initialized. This 1MB sliding window,
+located at a fixed offset within BAR0, is essential for setting up page tables and other critical
+GPU data structures without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe Bus Controller Unit)
+and provides a CPU-accessible window into VRAM through the PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+<------------ (window starts at
+                                    |  |  |   PRAMIN     |    |    |     BAR0 + 0x700000)
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1MB)      |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+<------------ (Program PRAMIN to any
+                                    |  |       VRAM           |    |    64KB-aligned VRAM boundary)
+                                    |  |    (Several GBs)     |    |
+                                    |  |                      |    |
+                                    |  |  FB[0x000000000000]  |    |
+                                    |  |          ...         |    |
+                                    |  |  FB[0x7FFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+PBUS (PCIe Bus Controller) is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1MB sliding aperture that can be repositioned over
+the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+The window position is controlled via the PBUS ``BAR0_WINDOW`` register::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    BASE_ADDR field (bits 23:0):
+    - Contains bits [39:16] of the target VRAM address
+    - Provides 40-bit (1TB) address space coverage
+    - Must be programmed with 64KB-aligned addresses
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: SYS_MEM_COH (Coherent System Memory)
+    - 0x2: SYS_MEM_NONCOH (Non-coherent System Memory)
+    - 0x3: Reserved
+
+    .. note::
+       Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+       target values are documented here for hardware completeness but are
+       not used by the driver.
+
+64KB Alignment Requirement
+---------------------------
+
+The PRAMIN window must be aligned to 64KB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x000000000  +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x0000FFFFF  +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64KB-aligned boundary     |
+    |                                                         |
+    |  0x123400000  +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x1234FFFFF  +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0x7FFFF0000  +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x7FFFFFFFF  +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index e39cb3163581..b8254b1ffe2a 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -32,3 +32,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/devinit
    core/fwsec
    core/falcon
+   core/pramin
-- 
2.34.1


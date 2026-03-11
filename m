Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669C36403C;
	Wed, 11 Mar 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189626; cv=fail; b=HDSpl+lwVyOFzHaJnsRh/1PhkuDRclEpOQ+BV3qfCmWoX5tm7fiWCEwwyQHVZvjdrjtRkcgR+vLxw6l0QFYCp+Q4YVhGIMc8peuLm1UyqXXuaur7vexcAgBn8GgWy+xjXu4h4DpefuHSgbb2p4muimAF6FAIuzhBJkHFKCh7qC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189626; c=relaxed/simple;
	bh=uDqLNDhBfacP8I9KD4Sjft86O+uIXahLy/vwm5OvYWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7dzvS8UT9ADeiXxDQabwpf5wwk0wsZLFS+RYH+XCAVcbtNjyxBluS53v1kRGzeAoBoSdbrQABBPud3vbuTrS60XeviKxpnQdbJ6oiIJtvGr9a5UR5hdktjma8QsQwPlx9jAUX3r6gvkYkjUOOhVjF2cc+Z6Gg9Kb46onBQvq6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bCyU4ETh; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bCyU4ETh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WguMJqpgTyxQ+fpxGq+WTYWzjRvUIpF6E8J/HA86oHML3iNn4bUY2Dz9nnYd373MPcCIABCTLRc3LLDSjP6iHfD458V9c7ZVStiXLmK50thV9rAveLp6CbfTNeTeS0lPGu/r2NcQxD3oe3pXUH+V+SyvvZKpkODX7H6vGss9RF2VMTA38a6WDez34MHb1ms4R8ZhcoEPsC5ipvjnIa9JCUd88STIhgnQ3XLTMhN92EJ6GCQDT49McYzL3B7I8Uqs4Pbc6mQG6ZxNHzIrWvS5snM2BqSDs3hLpjtqvGSejOv/NT+er9v9nXO26bSwJo1MefLTVwYOKPFpDvAgphZFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Gf71f1+HF14bhLysIpw4Ntoz2jJyjAr3DBKm3rwow=;
 b=P8Qg20luvddCBGe938LVzjTpn5U9tD7z86nIROsJko4W1kv/Oi3yuXf0dMNmKDbknL0i5h8PjOoaI+XaFkr4g0FrLb47CGBk6RxIwx3MEWVZ6A1WYyoReH64LhAZwUD6+5+ZotMhfI1YJC2gQK3BbjHz6kAtaZR5WU0GQ55MhNLqEqrr5SH/awHv1FpNyHmrD11PQvwqx10mRVHHm7b+OE3PjXi5f8RY+QYqZNkKnYSXh5mW/+4/oC6MStRhmTVt28Nx2+uC7TQZxNNq6yC6D4PJDfZzk/XcuRFo3HAHQVPnyRrubkpsGGoHuFU/yH35S1k79mwXrdH2WchoCfNC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Gf71f1+HF14bhLysIpw4Ntoz2jJyjAr3DBKm3rwow=;
 b=bCyU4EThboTO4kypKBG8ElJ4heSJwdatSN2QurUiXlyZRteLOay7cLPNdX4vQ+ALolIb10xNIPrj6aouBTsZHov1omcMbV6WRgJHtXKh9TZQsZ5HOOW4jLu7sY2d9uvZjkJzTe7wEszerQIjUNK6kreMEFjDwikIiu2VKy+JGB6vAKVvmXDW6AF9KB1Gghvm5GBUtc7JLfWW46GOJ1ydqfY3ErnxnRmeUcjXArpfWzPb50NsSz/W5nk8u9AAfvQoIBoUUXbGE8oyaWtnI75Z1w19NfuAOo9zgG7FquiF7md1iohBnns/v/Om0MNnmDnNxhlx9EYby3mWSMglrMSKng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 00:40:21 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:40:21 +0000
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
Subject: [PATCH v9 01/23] gpu: nova-core: Select GPU_BUDDY for VRAM allocation
Date: Tue, 10 Mar 2026 20:39:46 -0400
Message-Id: <20260311004008.2208806-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311004008.2208806-1-joelagnelf@nvidia.com>
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc91a76-46f2-41c1-9737-08de7f06c675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XZH4fRBF3oPXozAO4J5fNw5cs0GhQz4M5Vd0dyKbI2Niv+z1/zdou1ILdgdPH32xnj+PwXzUlAOJFjqMNO1lSulqtbJtLlMJHWDa9cuDLEreNt3u1eDNf+/LzOjGjr35MHW3kdmsLplSGH7pEhACzr4CQPr4r8qeor6lf6jBferJo739Yrr0tIhZkcNtdqmrkIR5qdo7fTg7LJ4GbQtrLwy9eiIqpXsc+H5FRaPh8gdqTdzacInpcMXzf9ppy6zs2pNw2hXwEKUGoXEWNjv5GxVxnDCX5kcbzijx4hXt5mRY+nsK4rAHJN7D3ZWeoxsxc7MiMZvKO9EE2+mAi+ImyocXkEgDITB2iwc7PO/200QAFZBksSBWuwoRhycyGQxLITH40CjZEHcxpWR6BngQzX0itQ90Fwsq0Wrcj+33R5e7FKEzVEZTDYg1Z0k0hw95vr5W3oPJQsZhKLBV7zR/GpaxAEj9ESF2a7uRPusECq30i4JmYRkiDpOd3tbXooUkftw1Sk1wtewgGX3pyXl98e/ScueuAhmtwJuogV4lfnpYQp7DPgdecksVRf8QTyKhguzi6NEunCCo4+X2OHSKdMqVIPD9jgYmWcaiTaWIVnublE1vygeLy66XQNSLbffoydq6QMuEHQGdhuT/RfjCKYyJoxrDEXS6Xh8uzKf/tYXca4HVYRrQDoxkfS3maNKpRZZvlCZxyRXgXmbMuOM8mVqyjtqvP0NUZTTta/pLpmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+tUh+016huiCrc93OUnoXs7ahwsdrNhkww3wAxbmsIUyrY+MFY+NqT3yFjM?=
 =?us-ascii?Q?ptiICuKtZ/PwCH2KjdmB7KIegl3g9y9ungLvlTmGXdth00sDhnJyxAmUSKlg?=
 =?us-ascii?Q?xtkiDaCslToLZqqkvcN/ZLWOoU4Wv5uFwqvlRG2kgOqLarHIu8/RkUJkgYHw?=
 =?us-ascii?Q?2Ct8lXpUEr1QLCRNsr/tc5Q9fBeoV+z98q4cKib+VlPb9RowezNNEcwxdOVh?=
 =?us-ascii?Q?9ZoE2GESJ+nsHdJ1GQKED5vmN53rwV1ywg+wli9LjO0iXlVnlGQ+4Z+cT1KJ?=
 =?us-ascii?Q?uEe0JPdSWq4s2gdu2zm+bH49fkXEM1QHjx4Kaxj2EUMh43oDR+BnIuVx8M9T?=
 =?us-ascii?Q?d92GHk1Sb1H/7c4OJclLB/nz1eHLVxQM0SW0XLqYSUA7tJ0dghDe8JTGtG6v?=
 =?us-ascii?Q?vQcvqNzTUJtwZtOXm7H+KBFGZTmdZk+pP8iyrwfIyz+bw6dntNcuECZ1N1aq?=
 =?us-ascii?Q?ofJR+lT7IIXuYEScOr29ovo0OQ3PIeQZMqnuhS/CvVtpb9x9IH+V1z2fYTFR?=
 =?us-ascii?Q?02aFVEOcD4Zi3xLdAuYmKf3iPRIMJLQbz8fwz25uNDsF+UudW7M8QERmWZfJ?=
 =?us-ascii?Q?Pi5OUWiE4DcjtMNdGwz1gz0wjKGy3fdo3+fX4GjEW+PT8gghDlkEWmzEm9T+?=
 =?us-ascii?Q?UyYU2jIPfPyNa2jWygiyGYbet6ZtKK7XjQWIEE9mqNoFKcwtDw+tk5ZB8pA5?=
 =?us-ascii?Q?NkftpWtMMCdCbK7KVEZClPioiMRomQi+40nvXCrj4UQM5ECqTHoL+bXqsWUz?=
 =?us-ascii?Q?dY1VNKtwM6BBfL/muk1mV1TJYUpQJhmA2N9CtLvtVfsB6K/EQayulGI7T2Eu?=
 =?us-ascii?Q?D08T/rP+eYPOsAzRT0WF8fI/k/HlVo5LHCeTepuJ9pFIMBNhCUSyBHY9h0+0?=
 =?us-ascii?Q?l7IFyxM5YXvNQCeiohSPpb8FDSZ2H6MZnSY6q9zSVXX8VCK4A56d3z/ThHu1?=
 =?us-ascii?Q?zjHmQoWLIKZhQtxuRBOssT1n1l8wJOgxMp7SYS2q9GpJSrf9Ty0mC8mscT2m?=
 =?us-ascii?Q?TzbCyDAX/6d6k/CphTbEJcLcppPCMErvU1QGEYH5xkrUAYF0DUszq1QRypJV?=
 =?us-ascii?Q?K46ys8VFOtIz18qL3+vabgMecE6FxL3ocAOpZ3r8wgKFmsYNHLqdUlmnF9Jq?=
 =?us-ascii?Q?5ferryDeBQ2ViWwEMG0OhGjXEwlrpD9xMWaKLAPpqBcRrvnIiTiWStMXJJnc?=
 =?us-ascii?Q?2FcgkmjkQfUShlGiyX38OeGtLAh+wMoyfBe/uVPgSG+ErvViHrOvnnI9v5zo?=
 =?us-ascii?Q?AoqI/Xn1/FFgLOb5ykEIortsBL2NgiJlYzTobS4xZX7Ok7eJlBgmbh5NOVQZ?=
 =?us-ascii?Q?Z7K5dOInLpmhebwIQWd/bAJvXxVwHpU0V/K3pL7PO2Coos7msuHuCt2Q0/fg?=
 =?us-ascii?Q?spUYShm69/Z44p1mLxm3rA+YVSm5GJZS1pgXlKmlAoyLEYaIqoePAKUsfA9s?=
 =?us-ascii?Q?DtvvSRnxZCNJ/vI8eWkJT9lfEJ3FxoxjVjll47I5yUiHL01dBkW/Rvc5je4J?=
 =?us-ascii?Q?aLuAOf9vZNB1g6i7H7aPj0X6r+EiZSPKMOKeUw9055OUaMSU1u5JfLv0t+v1?=
 =?us-ascii?Q?4pjClz6Wsx1Pxb60KLTAKUfdnhoxezbs1Yj7iQCb14lq6iyoGLhEPFM+M688?=
 =?us-ascii?Q?l9MWs1xPFDUUJ4fYeWlo6LFs6fSO6MEKQFPRXHcrDV5+Uc6CF80h5YX5Mwhp?=
 =?us-ascii?Q?9Decr9XjlMno/tMv+bk6MrqbJzP5xWyvv23zlrvCOn7XKH0sfYBVUeUv97/h?=
 =?us-ascii?Q?vULJlF2ubg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc91a76-46f2-41c1-9737-08de7f06c675
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:40:21.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1tNdHFXpyLqvC2xBQO5QZ/UZZmMxp3qHp6UXBW4mRvemRN3U16/leXdOBgYZwg6IJed6YlyZJqW/HAydXtGzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

nova-core will use the GPU buddy allocator for physical VRAM management.
Enable it in Kconfig.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 527920f9c4d3..809485167aff 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -5,6 +5,7 @@ config NOVA_CORE
 	depends on RUST
 	select RUST_FW_LOADER_ABSTRACTIONS
 	select AUXILIARY_BUS
+	select GPU_BUDDY
 	default n
 	help
 	  Choose this if you want to build the Nova Core driver for Nvidia
-- 
2.34.1


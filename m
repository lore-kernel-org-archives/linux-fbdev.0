Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396F379EC2;
	Wed, 11 Mar 2026 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189677; cv=fail; b=eiDBBw1AAJhwrDbfn9jI9MNY5NlZn/7lk61KIibAdjFczP4SN71F0DLqVD8RKNlwGuPBaToSdTFyQnYmGgKOkLPVMLkgzi8vo1dzScWqYJQ24FNLNjxcoXZotz6JL34bIpv/SabyDMOx/oJ/p6W+4vkYo77x/gezo1YYL2dOUUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189677; c=relaxed/simple;
	bh=rnx444PnCtA94rSh9aItb9EVpIhoQ5vngndzqIAT4Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L66AaohW986eYoET8MmIo/5DXSVsyR/QMTswAeO4NGGYHAt7NVLF4EgASu62bb6nLR0jCDp83zo0MxpeV9KNci7L+6NntYgQHQnYUG1A9RcC7oP4B+7647Iiam/TGeLm+yOYneWuKQMD1VOI/f0u2rd89DF6/66RfBJ7P0U7lIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvoOQx4P; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvoOQx4P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM6MEZeKnVLkDlBryEICfhizCXrcA2rQuyu8/aWpcLmIRr1tp4UFuXES0nVxM4lw6eVX9YUA4OOcTuftIenXvdFO2Coa8aQ/oRCtSOylC8/6s0IimNTgUvVd2FSRPLhHKWhk4syv0rUDadEfjoz25ObriJxUJIXgd//BIPA66elE6etWlWZ76968yUGf6FLO5zCIli2ukejnE+Vsv5j3Ir7BPs2A0ihnYF+qh0JKAgr0eSzxhIdPZ8GlFSq2suc3b/k0QDZaDDuVxjo0iVqw5iltNFU2/Ud2PRJ0Fr4EEsBYcyPw2EdNd8fvs63qdJoz5TleguaaR+tWDiezoNSVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r23flpPO2x2FGBKfNtIe0jySrpN9LR7pr/dMPAqpvn4=;
 b=fmy8bYrNvXjWkXsWs+3JLSyHKQB3jNcXVvwvaOp8+LW2AU1DZuLBIh+pM3Cpr8lIelFv44l80vHiofKZYb+9OI+qQzVEEQwb6f2v6EzNxEBmf2wZBYsn6Y0LSc1woX5dy4wJ+9pJz8c+OrspO6JNec+XSQqsvi8t2SjKieuehdjQC98LTt8+GWeGAZWpM4KMSXJSrygPyr2oq6f83gcKLVx9hgt3e9b2gNAyynQwgGwTHDkce78twexOrBXBqyYCFadxKrUU1vBFoV3R4qZWQlVCHS82ousZYo63O+qWFuZufFBVyJkyscel6tP3oSvtJsvYtwvvJ75ealTYvF28nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r23flpPO2x2FGBKfNtIe0jySrpN9LR7pr/dMPAqpvn4=;
 b=HvoOQx4PgOy+xSz9/6XNkWAphzoLA+I4iY+IUuUR1oy2mqZGsyKEOxcwUQqQaCYbcLfoKyIvH9LTngv3EesvzWyVRTeHUP77M1f6apW1Q0ipXGiXpGJtCZureZyd9smJf5r4FpdOiidcU0HMKtxKKyMdefGvZrqYTJPyRjRT/REXpLeF9W/iaEldWLeIPvT2ydrLVV2QFE1W/f+DhSbeG6ijkgLCcm1lEG3rqytx7cb0z8gOgR7bwTOWgxnbZV92gySyAGqS8dgRJ0FEayFNSxoseoaJjaxHhIk8UH5vkgB0BQDkkDCgULy0hNvGbUcKDW97G9iswpnC8c/jltRpVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 00:41:08 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:41:08 +0000
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
Subject: [PATCH v9 23/23] gpu: nova-core: Use runtime BAR1 size instead of hardcoded 256MB
Date: Tue, 10 Mar 2026 20:40:08 -0400
Message-Id: <20260311004008.2208806-24-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311004008.2208806-1-joelagnelf@nvidia.com>
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: cc213f7e-3495-45f6-7724-08de7f06e248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5i3om2KUFJm8qoxlCIT1Gm/im79GY2pDUYZs9+YHOKRXTByhUVUvQk2bTYHeWT2ZsBY4kPXGI1w8K7bAPsYJdGFdCD4T9KggXZQrKgzG27mFZXZE/fHADXv9GQauRYVdsrQaog/MAgVuRNs1F14MjzgxfENMFyUOi7x7y/mbVCeyxBhW6aVHhMchFw2FD9gLnTI//qHDd71A7e3IK3Mp8icbb4nZhnF8Qz5hddUNp0x7HJsmZEDk17ubLyszVkbx3dd6Kms1vQyLmN2M26JmvB8Fi+VjcBsKalL5559loxxSAAwrhh3PG/7jXE8ZAdwT0cOXWU7mA60VDmYOoYdVLEM1VnD0kemmgja9AYVzVljFUUYnH5dQqpyM51sWPP6WsoDjwOxBU+1EgPCi/5zUs2YmuWtEUnEysD+r8wUyR/3aNONMlLFNa9UZUHS+lvyTp1VTL4k5q4hepQFzxLBDUOaa3CPQEwyjiy/V7Pen8YPKYu7E0tQTE128hK3YIfHTFCMsEbRGgSBYfi0vaEQTL6nan2Z1Lr2xkUhCSzVyzUiOkzq9BtfW5Tzc3uN7SEO7GLd+BUmwjoPuhDu53ZLrtoS5/f2cwwW7c77zEnksaLF4H3VN+QIPr1et4QUwLBODYo9gjrjPvrNTXKhPiGCfBYXPkZM9qv1VseUfFzjLMSeZsOKSI/+G6HeMErUn0DNeCnenJCHhRi0VnWSOJMuGfV/xe1ujmVCP/TGEIzmElVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHWqRe+hUHiV8a4xo1W3EsDph6OUyNiqdB223mR7Npbe5mmSnCuGd5cE0GKC?=
 =?us-ascii?Q?+p86z3lmgnslVkIV5INeDJq3chLlT6BPut7srft/Q6+swdpOMtY3T0dZti3V?=
 =?us-ascii?Q?0ouKG3Jm9OgfJ59uInMbaJxH/MTEoCpchFEM4PSzr7JlEOxaQzvQMWzTkYan?=
 =?us-ascii?Q?s89B2LSFKY6+VLnR+BnlXRGaDT/Bh+jHXrHIapC3MIUjXgJZCKjKPGOXhbYS?=
 =?us-ascii?Q?FPn8Ld8sSMB3ycfFFp4kJ5UV2p4OGNgG4epjaTm1m/5rIyqMU35KABiYDcGJ?=
 =?us-ascii?Q?fFwuDJtAY34mDnZw2w0/lvJi/DpMFY6neeiqJr8ZGFcWUrNzzyeGtySo+vIN?=
 =?us-ascii?Q?GTusQ1f30W+GsBVv8LuFE+Ub+QpGloR135TvRZnNmDxZq6VXMNKDc/QCYWuk?=
 =?us-ascii?Q?AGrigEUtr5J/Rk0zwq4URj4zykT5SP3psh1gAm9ebiPzhaceqCaqyEcRo3vd?=
 =?us-ascii?Q?xi3ko7z6PHDsDUNwz9oJZ70uQ7SAsFkBBkgEryRritYQxLBqVA579Mk6iPVx?=
 =?us-ascii?Q?YHVsHBdPDt7ND4KU99HmOzfc4n39msc3Fvo7+Il1ch5dxwgQHYSS61sOBgBM?=
 =?us-ascii?Q?8q4cCuRV35t1B9qkCQrDXkXEqXjvMR1MFexLYNsYFmDklAgyzGVHIIpZiB+5?=
 =?us-ascii?Q?66kSyyNMN2oRTA9af1ewhNluzqAerbhoFDig62ENGWrtTOfPiKYcNHvcit1W?=
 =?us-ascii?Q?+svZ2kWD8QYdAH0xkuPXWGcTJmxAVSCx8k8IKQiuqGVQiR/2UHuZHPSo3ukK?=
 =?us-ascii?Q?U0qH/QdPddHULFznxZsUuBIxmzNU8UWLLSeeoaeDlAZchCeC5UNZQYPyuIdp?=
 =?us-ascii?Q?HNDBmy2MRYdHJJ1IoyNRLfJelpW/2tVtc0Hd+UZBrAM9nd3itAM5zOlgy8sA?=
 =?us-ascii?Q?du8C3o2IukHiX2ZtBmm/ofU/S1KwcBem6FYyGaVojkf8lww8ihSsAszWbw1D?=
 =?us-ascii?Q?4+xC9fS5PAtNR26NtG1aJ6o3NBfDYhyS4F+iH7kCcN9VEUWGtqWjSinBYKLg?=
 =?us-ascii?Q?wYouh1HxK/bkyNRxuQ5jDGrENImWcWWt0ByGzgWRJoTJOlyezgpBNxDqJs6/?=
 =?us-ascii?Q?5dA9zkJp4pFmUA3gkMHgIjM6ZBQh69BYJXJoRy3e/ZldAMX9oi1Rv0MlohY0?=
 =?us-ascii?Q?mGHzjjudbmAhiImzaSWxLrih5YGSOq7VpQMqVxVsxqfGAnbjaa9G9BhV8/7R?=
 =?us-ascii?Q?lOjtAJQV+8EhWjgeSUYd+sP1B9LyIVzNAV1IS7vZ7L/KrOKHGcZuP9xDuro6?=
 =?us-ascii?Q?i2KlrtVYtHb2uiKcvX/XLAp8gyhjS3NbBDQkcrDrxDILIal5Qq+qKRmTA8Mr?=
 =?us-ascii?Q?X01ZU5AHUgcoLd6PRWISKAIuVZ4UpXgH0p/GbOj/FBNbvuvg0aG+EZtEbO+j?=
 =?us-ascii?Q?KqmtqACIRtfqEg9VymXg0OOAo1sVvCGhDZwUVtfjwqFQWxs4NrJ9mfdeZnnD?=
 =?us-ascii?Q?BbWsLFb0NPSBh6XGuV1PXPa4FCuqfyAwVM6gQLmYMUbXpjHzN4wPzojk89Kq?=
 =?us-ascii?Q?OEXRy1ce776tKJDe6y2mAuEIX/WvPHUtWVE55cI4NDHZDSVjlhOwf6kLdMU4?=
 =?us-ascii?Q?651uj9MbKUUW3Id085R5cwwoGXhuZN4jTlcxglxhXa7jc0DEV9UInQLdstw6?=
 =?us-ascii?Q?5Rm2oZAjoUG8XI1yUUDQX6ljMgVA7b57zfpG2ooFEJMf3kNmOCKEPcjbwU/V?=
 =?us-ascii?Q?vSyS+QWIKF/x8KFOrx94kaJx3cLE3YO9Y3Mqifo64c+LiGc7Rg9Vu6m0SLF6?=
 =?us-ascii?Q?X2kw7GDLFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc213f7e-3495-45f6-7724-08de7f06e248
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:41:07.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQrBaOZPVimPaZselqa3Gkid8a6rhAXwmjS6VIUxkrOYFGaRR/mc8adeLE1gVqS7XLQWFn2S3CkpZYY04cZ1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68

From: Zhi Wang <zhiw@nvidia.com>

Remove the hardcoded BAR1_SIZE = SZ_256M constant. On GPUs like L40 the
BAR1 aperture is larger than 256MB; using a hardcoded size prevents large
BAR1 from working and mapping it would fail.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 8 ++------
 drivers/gpu/nova-core/gpu.rs    | 7 +------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index b1aafaff0cee..6f95f8672158 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -13,10 +13,7 @@
         Vendor, //
     },
     prelude::*,
-    sizes::{
-        SZ_16M,
-        SZ_256M, //
-    },
+    sizes::SZ_16M,
     sync::{
         atomic::{
             Atomic,
@@ -40,7 +37,6 @@ pub(crate) struct NovaCore {
 }
 
 const BAR0_SIZE: usize = SZ_16M;
-pub(crate) const BAR1_SIZE: usize = SZ_256M;
 
 // For now we only support Ampere which can use up to 47-bit DMA addresses.
 //
@@ -51,7 +47,7 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
-pub(crate) type Bar1 = pci::Bar<BAR1_SIZE>;
+pub(crate) type Bar1 = pci::Bar;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 5f4199e41d16..4d4040d56aba 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -361,18 +361,13 @@ pub(crate) fn run_selftests(
 
     #[cfg(CONFIG_NOVA_MM_SELFTESTS)]
     fn run_mm_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) -> Result {
-        use crate::driver::BAR1_SIZE;
-
         let mmu_version = MmuVersion::from(self.spec.chipset.arch());
 
         // PRAMIN aperture self-tests.
         crate::mm::pramin::run_self_test(pdev.as_ref(), self.mm.pramin(), self.spec.chipset)?;
 
         // BAR1 self-tests.
-        let bar1 = Arc::pin_init(
-            pdev.iomap_region_sized::<BAR1_SIZE>(1, c"nova-core/bar1"),
-            GFP_KERNEL,
-        )?;
+        let bar1 = Arc::pin_init(pdev.iomap_region(1, c"nova-core/bar1"), GFP_KERNEL)?;
         let bar1_access = bar1.access(pdev.as_ref())?;
 
         crate::mm::bar_user::run_self_test(
-- 
2.34.1


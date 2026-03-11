Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1575367F46;
	Wed, 11 Mar 2026 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189656; cv=fail; b=OtL2ydJC+GMdKOC7rGCr3LswSKn75flEqW0BDPrTU8iA7p21UH6rxldyiSi+S9/PhBiK535QCMJsUXAdt32VLaQnU1b0B13u5LAQQmucWAYUu5U+wkUb9f17No3sbGEQ2/+pRcFgmQG+reI3AJobzG7wtZ6j3fEJy6Msy/x2yVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189656; c=relaxed/simple;
	bh=GCPJqmaGR7ObWgkF00CWKg/6vCAZ2B/IUKxZELlJxZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKz8dvMIKXGniyB0HB/8QS7A0xyP0SlNKycPhY/O1PuxjkIIQfnAWz5XtK6SNgMAY31tfB5xTyRnUSJv6NAlsxEo9jADzliF09puuWqu6k0f6JuV+lFavEi4KncQm+5zk4EPK6lG0cV9T9bIjgP1UdiNePVOsq6jvmJCt4oDZKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFfsM93G; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFfsM93G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASBoJsghbht0eVMnTzK3L/6+RSSYcWcWwMKSzmHlqwN1eFUZUBGfaOOQLNTPjrMpZs10uvqqZW1i0TD0xQos252BqivwbBjCQ8enGhm2DRdnANJPwA0C6gkSDSVvwdUlwbWztQzk6PY56CP3wB1aQ31qk2/0WzdkZXR//hNZI0cFSeffrjRy7BBesC3gm0ZajKX16QZlP952EzO5SyTUzba1I1z4BI8RB6ApxC1jg3OCRNPvUkaYFDr9ra/j9m2W3S9pzAipmjKaYmQyOwixKY8k83y8PHaBbCJ4+g8ZbEkNp8STO1n1v8/gSMHExq4ldTCMmVnNnJakARN5WvmuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rksV+yXc43KoUnNwhaGQAyhUqMJ+F9EIvs9Yc+doqC0=;
 b=fb0Ko0/SPgSsP6/deGfBrnEGDto2fNgD1o+Ie5wdOs7tlJPX8tx39TngWZTfazXJAIEXOVfqRbzQlhRrtGQXf90wMibTP6ctTY0zHff91N5VCDLaXzbhtb0lbjZdKeK4N35uaCMflfzZ9U73TjOFA6cD4AcWBY76MIQ995qX0sd+GsSG4n4cWdiLFdd2ActKT3gBOgGcK/PPcOu4s3zpbuqFiFT8/sZYJ/kJSSSF1WRg9GlodK2AcuSK+TUSE081bPNRvmwNBL13jSvKDJ9Xwcpzk9I2HYKO5b8jDv4IvzNUDD7i30+OyWtR8PPLyNjmr251VKur53AgjTOe9nXpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rksV+yXc43KoUnNwhaGQAyhUqMJ+F9EIvs9Yc+doqC0=;
 b=iFfsM93Gwzihh7VZRIOmZie2eUG+iA5A4SWQoNFTgIBG3hzGgTIF+xtNtQm5JYLMUFHz/u4VULTFSTOfqFCyUGrUbuMBlCHwzToVwZPtXdi6IvXIIX66wwVyJKn+TMf51+nCaJwR6c11figEnX/3EpAuZE5Dntx/Dp7xOOvKs7hekHdWakI/00a4ZL6VcI++Wt6M85crYRSAd1yASSc5EKmIrcfgPA4wDbfTZ9HrkI06SU4kQXUNMB65ew0/YPDzj8bkFZ4NfUi3MD2wNcdTD4FvOPBWUQQgV6cqnIcI4thTrgNsR0y+qd7unMSr7Ka4P0ZIfeMeiGN+9gAhtjcofw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 00:40:42 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:40:42 +0000
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
Subject: [PATCH v9 11/23] gpu: nova-core: mm: Add common types for all page table formats
Date: Tue, 10 Mar 2026 20:39:56 -0400
Message-Id: <20260311004008.2208806-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311004008.2208806-1-joelagnelf@nvidia.com>
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: dbeb0986-75cf-4fe9-5987-08de7f06d318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r+OaLb2Mspc+L5o6iybfEGx5Yq5jLG14rM+OuVrF2qsAURj5Jew7W+jWuSxz1R5wUwV5F0JQAL9BUQPf1U9SS1J48KcJFs6vPhatQXn25bp0E3OhvB90MmmT0ittCO2iLrGUpB0/P28MNqbS/dYhcPq59pY3qHTy0zaSjQO4MtzVwUDwjnO386Ecnl9NFFRzxyYHbpA6AbUtgn6rrq94m+CHWJ4akRTz9ImjPf62jN9Ir1weaTGj2ET7pnPB5Ej1zatsl04av/jSGWusqcY1G8Iu1aEU5ZW9ziz1zk/xswVds5K3TjhfWYPayu5SULG0nVCYovk6YRuFfQihkcxWqWL6hG4A8E4wgGQmGvhhwl3Tx69v6YvzByEfa4UsRsUcJbm+VnUJI2nBLUtF3as+23JHB6OGFstx1ANuzYoYBZmmsxtjjPmB6RIsIwkmkZ0r5RUrQXRiWlzIpX7m6AmhHAJ8cJLXvaBFWTkch6zlKnMKOm4qCQW/PkvT86IUDGqRiY4qSmIkPVn3eqVYMoWD0imS21SeyHnArW/Eckd5eXrayParf8HbdC/BUv6yyAs7LqSwOMV8r0zIqz+8qPqt/W4fxMx4oIm8OG7o1vWvdyJbOf4pXJrfHNKMfEP+Da2IMy/yZKAlxYpV4+QoT4U/nxc+Tb/97j9lyrAPJN7DW7bEFPM8jbMiPmYwUhWl6bZ/iwQANh3TWVcuIlMLvZ/248L6Xi6SGXANwjY6CpzDZ+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gI6SPKXvhxhAi4m98o4bL0+vstRTX9OWmwtkb325LZ2Fm20i2xBzr2bwQrvH?=
 =?us-ascii?Q?+fBgf8S9KCfChcyhSdVVtVxTSHt2fc3TNmjDsoP6/eRr0LtnhbXm/BBhX5A8?=
 =?us-ascii?Q?stpaaOQxW7a3dONxXQwuuIaMsh0XpTSDYkGXMZSPte0jOOX29FN6Ck89CFI7?=
 =?us-ascii?Q?8AtIVobfnFzVJq9slU3+uX4OmqZGIZn0Lm21spY05XeapTqJcLHzKdCA0Kvy?=
 =?us-ascii?Q?DpCu7o2NP80BqPilaQocPnLbhWaQOZyR6DfJpIvut2g3VuFF584j6olAm2cc?=
 =?us-ascii?Q?tvw5NqFJAF1eFY6+n+EJmOY11Xanlic2MQT4BITAndNJFNCNXOMCVMr5uVSg?=
 =?us-ascii?Q?YoumccRtoQe8mNaTdKueIXRBtAesS16X/zIwyhmS4A4jhFoxpr1sbFKntOju?=
 =?us-ascii?Q?nk9sowFGt37Re2SlraEEkSpqvvK364MT/KsH8b4B/+f25dhS6c7HLjJe08kg?=
 =?us-ascii?Q?pip5JcrCsRbOAyftU0w5FngbyYKCwqfvP8GI8m6adf6kRh5QZaBmiCK3FVnU?=
 =?us-ascii?Q?XSjuMaI/+tMC98MKRL2JvqLCLHLwCsCk828Y4ACxBOKJ6LTCcR7WgkEwne26?=
 =?us-ascii?Q?yoSMAU7oG5UEoobiTE8lyyALsAFzkj8P9R9GAHzKUXGdlbPVLt4AQZRQj7JY?=
 =?us-ascii?Q?thBc6C44HdyGAleuBybtwB1GZUWtfM6vaDm4aQnff97De/gi2YJyQHZtB0e3?=
 =?us-ascii?Q?QVnbjnn58zZmN2crX1Z3tI9r2eaYCDh/b35Dsngw+BofnFg/z6klUowoSgEL?=
 =?us-ascii?Q?7Mpz7KjR9JwB1YtEzw+5hyupmWkoZu5eNrwviRFNmcqM3KPHZ8EdrwA9faMU?=
 =?us-ascii?Q?SywaL7JgFTG/gb8us7KLlEszwjaH9t8NU4oLjYtxX1gSZWuCvjIWac7GupnY?=
 =?us-ascii?Q?zxDhjq07xIGQJ+kJt/gu2hTBZjo5aOvaqUjexGU4V7iJ6vNBnwv4zzIOflDw?=
 =?us-ascii?Q?xTgNDCcB0Sb5K4PZzk5voeWHiu+0mQ4TnHMbofV/XT0MUO6mRayN8DpjPR4K?=
 =?us-ascii?Q?FaUUlLdAOAVrk32yKZs98Q84gjOKRYh8E6g47lUcKCuZek69b/W0flFgIHyJ?=
 =?us-ascii?Q?f8OKgHcWjIB1ZZo6y7iN1z3q6eeF+bsfX6GqdeOJTijRM1Mkb3N0q+7Q2/LE?=
 =?us-ascii?Q?v7rPEp2vVo/Hq6RMl3vkCvmAfH25sx1IR8gyCygfOhofZ3SA+IqgP7ob4FAB?=
 =?us-ascii?Q?BaS4TK67LGRyt9NuAUlpTf/YBMdil0HYes2ia5mrJegVyEPlcg2GU4Py8zra?=
 =?us-ascii?Q?jVjbshQ0DAgxoxkJjjsvxLCJOq9ADAtibjgPYVSxWYw0iklysk3W4ZvO6Isn?=
 =?us-ascii?Q?UDi+A0vCoB0tgZdwiFOR71W+WyBCp9577nQfI4CMvxU7AYTlHiPRECKG2VMp?=
 =?us-ascii?Q?zmqDW+7E36nTX7KvcjUevGjDNVtKTn4BkrtF2vFU+vIUrcFmbRS/bRhv6COo?=
 =?us-ascii?Q?e+GtmeFPJnqC47zxkgNuSygsTVCxD/Ea0PwfSah9ISIXfEnSuSwXa4wt+kMD?=
 =?us-ascii?Q?uw3s+hZshTu4gv8A1f1TjzgzeQqcrnTneOnhg/QuRVZToA/Lf3NKTyTM25cc?=
 =?us-ascii?Q?seE/Rcq6ctkls8AvNIwSyv8nu4gucd5javz8hDSF9l8UZkT/jgDyv3qd8kCO?=
 =?us-ascii?Q?vqUFpQ8wEBk5q02gwNUyQfqmJ1z1cfgonkJmrLGT3a1y9wc6+0Xae9qrVWdv?=
 =?us-ascii?Q?7/pPRRoe8R1It8fc2/0cN0kScZCsEYRG+4PuPX8PLAVAVIuQsgwocmNH+qkw?=
 =?us-ascii?Q?vH+2pYygrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeb0986-75cf-4fe9-5987-08de7f06d318
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:40:42.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kXQ4WsIEKWAiGgmldu9hGBsRx6PhxIBDbG/JDY9NGHE/6Qg4VD/YmuzdeLuL+C9HiAPZWeasUY1rKAetfbIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add common page table types shared between MMU v2 and v3. These types
are hardware-agnostic and used by both MMU versions.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/pagetable.rs | 155 ++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index dd15175c841d..b0aad90e94bc 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -4,6 +4,7 @@
 
 #![expect(dead_code)]
 
+pub(crate) mod pagetable;
 pub(crate) mod pramin;
 pub(crate) mod tlb;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
new file mode 100644
index 000000000000..3946ce2f50a5
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Common page table types shared between MMU v2 and v3.
+//!
+//! This module provides foundational types used by both MMU versions:
+//! - Page table level hierarchy
+//! - Memory aperture types for PDEs and PTEs
+
+#![expect(dead_code)]
+
+use crate::gpu::Architecture;
+
+/// Extracts the page table index at a given level from a virtual address.
+pub(crate) trait VaLevelIndex {
+    /// Return the page table index at `level` for this virtual address.
+    fn level_index(&self, level: u64) -> u64;
+}
+
+/// MMU version enumeration.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) enum MmuVersion {
+    /// MMU v2 for Turing/Ampere/Ada.
+    V2,
+    /// MMU v3 for Hopper and later.
+    V3,
+}
+
+impl From<Architecture> for MmuVersion {
+    fn from(arch: Architecture) -> Self {
+        match arch {
+            Architecture::Turing | Architecture::Ampere | Architecture::Ada => Self::V2,
+            // In the future, uncomment:
+            // _ => Self::V3,
+        }
+    }
+}
+
+/// Page Table Level hierarchy for MMU v2/v3.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) enum PageTableLevel {
+    /// Level 0 - Page Directory Base (root).
+    Pdb,
+    /// Level 1 - Intermediate page directory.
+    L1,
+    /// Level 2 - Intermediate page directory.
+    L2,
+    /// Level 3 - Intermediate page directory or dual PDE (version-dependent).
+    L3,
+    /// Level 4 - PTE level for v2, intermediate page directory for v3.
+    L4,
+    /// Level 5 - PTE level used for MMU v3 only.
+    L5,
+}
+
+impl PageTableLevel {
+    /// Number of entries per page table (512 for 4KB pages).
+    pub(crate) const ENTRIES_PER_TABLE: usize = 512;
+
+    /// Get the next level in the hierarchy.
+    pub(crate) const fn next(&self) -> Option<PageTableLevel> {
+        match self {
+            Self::Pdb => Some(Self::L1),
+            Self::L1 => Some(Self::L2),
+            Self::L2 => Some(Self::L3),
+            Self::L3 => Some(Self::L4),
+            Self::L4 => Some(Self::L5),
+            Self::L5 => None,
+        }
+    }
+
+    /// Convert level to index.
+    pub(crate) const fn as_index(&self) -> u64 {
+        match self {
+            Self::Pdb => 0,
+            Self::L1 => 1,
+            Self::L2 => 2,
+            Self::L3 => 3,
+            Self::L4 => 4,
+            Self::L5 => 5,
+        }
+    }
+}
+
+/// Memory aperture for Page Table Entries (`PTE`s).
+///
+/// Determines which memory region the `PTE` points to.
+#[repr(u8)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) enum AperturePte {
+    /// Local video memory (VRAM).
+    #[default]
+    VideoMemory = 0,
+    /// Peer GPU's video memory.
+    PeerMemory = 1,
+    /// System memory with cache coherence.
+    SystemCoherent = 2,
+    /// System memory without cache coherence.
+    SystemNonCoherent = 3,
+}
+
+// TODO[FPRI]: Replace with `#[derive(FromPrimitive)]` when available.
+impl From<u8> for AperturePte {
+    fn from(val: u8) -> Self {
+        match val {
+            0 => Self::VideoMemory,
+            1 => Self::PeerMemory,
+            2 => Self::SystemCoherent,
+            3 => Self::SystemNonCoherent,
+            _ => Self::VideoMemory,
+        }
+    }
+}
+
+// TODO[FPRI]: Replace with `#[derive(ToPrimitive)]` when available.
+impl From<AperturePte> for u8 {
+    fn from(val: AperturePte) -> Self {
+        val as u8
+    }
+}
+
+/// Memory aperture for Page Directory Entries (`PDE`s).
+///
+/// Note: For `PDE`s, `Invalid` (0) means the entry is not valid.
+#[repr(u8)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) enum AperturePde {
+    /// Invalid/unused entry.
+    #[default]
+    Invalid = 0,
+    /// Page table is in video memory.
+    VideoMemory = 1,
+    /// Page table is in system memory with coherence.
+    SystemCoherent = 2,
+    /// Page table is in system memory without coherence.
+    SystemNonCoherent = 3,
+}
+
+// TODO[FPRI]: Replace with `#[derive(FromPrimitive)]` when available.
+impl From<u8> for AperturePde {
+    fn from(val: u8) -> Self {
+        match val {
+            1 => Self::VideoMemory,
+            2 => Self::SystemCoherent,
+            3 => Self::SystemNonCoherent,
+            _ => Self::Invalid,
+        }
+    }
+}
+
+// TODO[FPRI]: Replace with `#[derive(ToPrimitive)]` when available.
+impl From<AperturePde> for u8 {
+    fn from(val: AperturePde) -> Self {
+        val as u8
+    }
+}
-- 
2.34.1


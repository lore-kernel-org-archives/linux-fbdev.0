Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E234D4FA;
	Tue, 24 Feb 2026 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973622; cv=fail; b=jjALC8W6sDrvxib0SjTMwAM1F0f+uBulX0+FL3DOjdv2aGu0bWknj/WclZO7mhZmdYk5m05bOI65nt8t1wOTYV0qAyGQ0S7WS3to2gNW0tJY8Mz9eE5XHLdg6jHTQiPXBCrEcqlP5Uai6Td/wUh5wcgrcdC/+aGUkl21tK9DzQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973622; c=relaxed/simple;
	bh=uDqLNDhBfacP8I9KD4Sjft86O+uIXahLy/vwm5OvYWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIcCLs0205bvOanLFsw7VajA+K/DuNzKTtfwrJzMBAyfO4m5tCaaWwP++6O9Y7ZBA0OKPJ+cbTB3I+Tw92HgstQGf8bSY2BOj9MgyP6ZwlkfCTspOvj6yVD3+4fZtf6G7vncw2Kj2bn223Ep98AdZINuT/sBJQzDL0CAqBE8tmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4HjSStp; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4HjSStp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/sNX7Z3LB8hlYK8eISNOBXAN+wg8dbQ9ayYJ56XynnrO+5FzyPkcngV3Si/R2bm4/flpdXtN2vTrSXJsTEWJ4OlI3mjolqzfHNb0qiOTl0ZhVWEB0P6+rhAP7crzw9Nbiqe4hgmTqIIV6Z1zpSv4QaCdS5L0wjt9dod43yErA4FczkVtH28MSXhxcWSI2+9WVzSjgthstaTxRPhrWRzdogYQgepMO+Te28U4Xn3dgz/iK2Yhmwtxev/U3uT/HAPYZyR40DaMKrOot+fK/qaJNGIDgoWVyrLiWM2GphDgdNtcIvBZxICFESHoZyZNo/mr4iAknze1gX9y7Ndfnh4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Gf71f1+HF14bhLysIpw4Ntoz2jJyjAr3DBKm3rwow=;
 b=pNxraH3A2ITuFp0ampU/qwWlvIQoWTjY8RhGNpnkAyrzom757TVVb6ZxockNPcxd2dPMp3GaNx5lkyaQyijaLNpmk35T3535VXwCbEicjUCvbgbL4/YxdDmeVrN1CRt/TTMZrPhd+zLBLXZ2/x9jQyIA3+9tABfTUSaVRb29pXSr2eZu75SntCgxfPMOz65wJhaq8G+7i7YfH7z1tjzqYR85zjCIp2Q5WkTzPuYQagMC5IW/1CH/+HAg0z8aGRfCPn+KTEqeqNw50WsXPL18SsVm2XvVkoe6c6XArC0gUeMzp4KKNuA7Q68Wz42XhcVNVd3fdcAg3652zOF4H1F80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Gf71f1+HF14bhLysIpw4Ntoz2jJyjAr3DBKm3rwow=;
 b=J4HjSStpg1ATZMLLTKYaju5Df9xxtCyRY2zIgmWHpEETVUaXG5F88WM0VQ7+1RpYNVYHwlQ4nMFAQwik8ibvg/YBoah/xYSJNvokoMamW4sJTsgLLUYsNjV+X0igDo8NkjtxOHsTfsRyKDYwdgjkbaadEV2I0hk8mmwdKwO0HSYRwrZvJVIEuFPdVKS9U8nCH1XZmogETs3a0LpBfl2e1Y1W+7B/WgAQ1zZrkt/J/fYHgOvkco3iNxbrxJim6keIPjrUsZOzf8Z+hP18n+tbTvXYIZSkfoJH6Tsv5MR1x2wcqLQbTmAW0PqLZPQoSxIVYlj8Vsnt+2kTt630gwwKfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Tue, 24 Feb 2026 22:53:35 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:53:35 +0000
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
Subject: [PATCH v8 01/25] gpu: nova-core: Select GPU_BUDDY for VRAM allocation
Date: Tue, 24 Feb 2026 17:52:59 -0500
Message-Id: <20260224225323.3312204-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224225323.3312204-1-joelagnelf@nvidia.com>
References: <20260224225323.3312204-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5800146e-dedf-4273-caf6-08de73f78a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDwuKcMi+biysWAEmN/7QL8stirF/1LQeW480LL8dijlaH4EEsoajIaPn6CE?=
 =?us-ascii?Q?4EvxUlwKN9zXCpsiseq8D8R/saRn1ijk4qOkcUZAQoOt1HTuuhB/7D56rlI3?=
 =?us-ascii?Q?nVlNc/xvyPAWGi4eEAkXIpaZPRy/ik9VQGDh+loN1MGTwhx6WOxpjIrNxlY0?=
 =?us-ascii?Q?QeXgdQwAp63sypS4J6dR9PXPBlryaZiWPcSkBi0AH2ULvOBOiOOddUhqRUOp?=
 =?us-ascii?Q?CytHv/Tar65Cw+usGVJ9108DSTLDUBhb3ZimI71rPppDj7bRoAjtAvy4vAS8?=
 =?us-ascii?Q?YFML9RqhXKi3HecdqE1tHgLV00j3MNsohVEBNkRVMWS+K2zH+kmdyKNnHBsW?=
 =?us-ascii?Q?tfmFtwnVdvzy+pEw8tE81D9C2ur4vSV0TiJtSXfhQ82MRXTv5x/lVHxFas1s?=
 =?us-ascii?Q?4a+ONrg7PivvNMdAJ/rVD6FgMIQIsQfoTf9kLmRqGn+8IFr3+2Y66K3pEsi1?=
 =?us-ascii?Q?3Bs4cnrWYinjoVJOx9f9sjtj6H9jtidSQvtNprL5GrnPC3QIVa1oHY0V319H?=
 =?us-ascii?Q?ApwCC5jVJtTUZ7cmcBFB0D4kui7/oaseNCz/UwNr+7YQrnV7KRgeQjMLNM4g?=
 =?us-ascii?Q?TdDt5j0tjvzqECt/ykBeho9vEcW9xfbhNaZ10lOPTbjgaE5+MZ/ydCt+pmF/?=
 =?us-ascii?Q?/5jXAVJAVyHHT6/tA8Up/S/NXYiJGfEPC/56Yws6etAqWIBOeOnco9GXeye4?=
 =?us-ascii?Q?4F56dFKi/YbTnrNVZ5kRFL2t1bjXjhobMTSoSTCvF6dDOCKfufce1rG+nu+x?=
 =?us-ascii?Q?c9X9Vv3nyPxv+7TLtW7yaDz7/90jUsWrlVN+RCdNm2m+0dNwX56CUOibNBP7?=
 =?us-ascii?Q?Cj1LdsImorPLxsPkulbor/jspnlRoAWgq0WI9QJgE0MlGBoQt1KzRRQ9N1C7?=
 =?us-ascii?Q?gU5IBL+AJmfymt1hIGaWO4JGkOXk6aYC+2Y8ghpEWfoRlAbRFO8/huJ0Strs?=
 =?us-ascii?Q?+Y8pq/wvp2fykf9KxWdNLEN2j8xhGHc7tKPOxdazU23FtLNQQcaVc6ttahJ8?=
 =?us-ascii?Q?l0meCl8v0yolAYDA1iSFejlxh7BckBBk7CL/3eGEEjkMXAqRpfOEkNaLP1iw?=
 =?us-ascii?Q?IWOSJGgCNvDRYFLkxE896lcYnuoj/hngO1ZaZxZCHP4DU0h8m0B8XrdAlkka?=
 =?us-ascii?Q?MUd9GwqhdI/NT1BT0OKn9EBbCm9JyCBuHuy2kUITjkGVh65e1EBJLmWcMJNC?=
 =?us-ascii?Q?kzfwhcJCgsVWFf/GbwW/Uh7o7KZ8kjN8GSonvV/Yx+nH10DvRIjPGNYb62TJ?=
 =?us-ascii?Q?u4LBsj+KuRM8OWrXRc9zydw6p2lUtYiYix4NTBctIejLZhg0vzjTM2feDpgK?=
 =?us-ascii?Q?XnC/aMarvpFUdA6ANodtZK0IInPmiY7nS88qBKQwQzxinVDgtgaU4ESLWYj0?=
 =?us-ascii?Q?5R3z9P7bRl0kCGR0jd39eb1Xd9ewb8BXkGzm3G/wtlo8djyTxCN0gPfHKKWA?=
 =?us-ascii?Q?Nh8JPg9gs26QlZlIdwkrGTulKaIKd8AlCOg/pB1KGe6oa1uyERv2Hs3D5fmh?=
 =?us-ascii?Q?YGiAB8W9Y/WGXTInvQsc1TNWxVizYIqfsdzH0y7nq/fgid1bx1AYa1s2U9fb?=
 =?us-ascii?Q?Kb4ZJhynrzHhCpYxab0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vy4MgQ6662HftR3K1JrmE050RIia2hpADovpfsd1IAEuCnDTfQ7J8xI8y83z?=
 =?us-ascii?Q?R2+r54ca2Iz7lzTUwmrcsz2Ugh/anwrLkerrYTP5fPuKLjcaFswPqz2jE8DG?=
 =?us-ascii?Q?p5KS8nvj6vi/7+bxtm26TZZ96tJ4U1Mw3CosUq6ZoBi1H3jGjEmCJsUObQxY?=
 =?us-ascii?Q?PE4T89ySBtGJiLI+7Ji60x0x2OGWfaNnjd7gBK2o5A97a5kSqUvXiy9X00AU?=
 =?us-ascii?Q?D/VmWaaVPyoxS+92HdG9SF3lSABuW3gmuGQ9j2TQkT9jGLRP+LAD0d9ZK8In?=
 =?us-ascii?Q?MJ0sGiElTWl48Cyjl+u50tbr7VjO9vB2o3o5cWLfo/Gj+mg8mu/DJOmUa8fh?=
 =?us-ascii?Q?IRpy3veKDuIXRgk7ugmV1rmNydA7qBohyAEh/vCrWzvAX6du0f8rhtTaldQJ?=
 =?us-ascii?Q?FvlK68l8Lv+uYyBPGFZ1vf/rjV9jbgnLR9aRsLiwTPK++JN6JquVjhFjp/rC?=
 =?us-ascii?Q?99b9LgvmC8UC1zLPrPJ3y8K3Hvyo7TgYvTRQYIqqrWOvxrTUBDSS9xYG6zpg?=
 =?us-ascii?Q?ElkB+B6Lk3YHjUVHYnLKFto+uDNZdJfhE4oVyezqWo9tJtItBY3DFwUJOUeH?=
 =?us-ascii?Q?N1XJf1nkq5HyzP+NYVimHWBx6V87ajNqFG/4r73RYiZEgSg0QoGrT9b9akZS?=
 =?us-ascii?Q?eCaknZp5cPyZ9tOS9UhIhl0yPdAbBy6JFjHB7rVE53jIIHKYrhbXvb3Ticd5?=
 =?us-ascii?Q?yOFBr35XxUlVQNrG7nvvGwKN6BHWSKNBttZo3iKDD7gSjgqnuDhfKNXqBKy+?=
 =?us-ascii?Q?j0ADg8SA2ifjUsdKPlUu5vhhKZAN0fCjnRtoFxY0jhtXHnNfI5AS3Rm5/TAk?=
 =?us-ascii?Q?gICmoEB906SiiNQ+Fk4+kH6JpcLucTv9uHKdevo1D1DDdVGl9dfZA8xaXEC5?=
 =?us-ascii?Q?fkF/B/cPYexS+7hAGYIkqUlXHbonyXgZvhnb2gS8zUxHwDZeYgYc1vsC39xy?=
 =?us-ascii?Q?OPhT2iGTnYBxb9dHjwmPBBglBW7sLDR7zljDDhWbmbpogWUewUxvBaD2HjxC?=
 =?us-ascii?Q?s2gPSnX8ogFtGiEf9vpHYcNzEQ2SkN5oT8rBZ2kMLlpQqa69YE8TcswpCAPN?=
 =?us-ascii?Q?6sMa9qN8U6MSNqaGcQmpKnImiJ70RyGO9hikpaHphBkYnEQncgUG8kCreAoR?=
 =?us-ascii?Q?LnRmd+aK09LDXMbGdojeeSQK/Z7TWKkXrGaAGwcgERq/D5yvvKIpA3ixWX4T?=
 =?us-ascii?Q?C0F7G2lR+LYxGxVAVxLL4zbf9gsudzWXbXpoSQ7qutkbiSYW54KVCirPEnIp?=
 =?us-ascii?Q?gB7XCmLHqsPLqTH8tM82OuPkd1WaD+AxUsWehEm1G18tTj7NDwW6y+aSV/T5?=
 =?us-ascii?Q?yE4M+ILC6uucDUzKO90WPt//APbJpW2kTr9J3w+znFT7S/bv7SHy31VSyt/N?=
 =?us-ascii?Q?pE1r9k43TWRHm6pZayzktsXnFCBn7/vY3zeSQJiy249a0s4F6hvFZ+L4SG8v?=
 =?us-ascii?Q?iLHcww+NXdhzHP15lYCYfP+En1N6TLFbBiuItJcGn+NmoxRXnzeV4zzo98I9?=
 =?us-ascii?Q?zeH3bDOpvCEWhSwH1rU4HdhB/7CG5Ak7JexjKz8WQc8bFwQqlqtX1odQnPTs?=
 =?us-ascii?Q?T/KFj1CVz7R0ArBLzdSA87x2k3ghkj7xx08B566VLeiVKWUe7KyknQLkdtbw?=
 =?us-ascii?Q?4JcSVSF1dSYK3oYxGSANGOwCoOoVQbi3Ap4+kUEO74duO7hIjZt1dN6+Bc7Z?=
 =?us-ascii?Q?NHA8E4ebECwh1wqmLEp3XGOv1ulvXcrHR2W8O1Yg6vn8KiLsgxpJzqfdn/FA?=
 =?us-ascii?Q?sLBlNfKyYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5800146e-dedf-4273-caf6-08de73f78a8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:53:35.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKuwYYkoAVjXiIyfjhZAVbT2cdJydWWumnABhCZOhTypddZICBuF3CMjyblj6svNHcK6fG8JXyZzZHxLe6bqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

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


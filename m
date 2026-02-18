Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73B32E15B;
	Wed, 18 Feb 2026 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449674; cv=fail; b=TaeDGiKn6Olyd8PqhjcyELaCAbVBfopJNgXiZECuwBMFWH9jcOiLHbMxCNLEZzPQ6Gd1va6GS0xIpy9VznWdPMjd7cxp/xcxJ/odWKNSQ47whA1GIjilj3ZYEol5ODiBVrgNPo9lx4e0ZTADWLyYZYVoESWoLVdzA6/scf77joQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449674; c=relaxed/simple;
	bh=Ns7P0tP39/MbhhI1Cp485GRdO7tGHqRw9vFY1sB6Kxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cT3Ynkcdx8bZSrATN69g7n2/wqUS9Y1OHzPr2p2rp0nuqfOBCscv/sdOonB0NiBkDzDwMfAWX/9KetNAK/QeFkK9N3pzXVAu1qEjBUke7E2fGILPoid1J9sa0yfq3TvGuExTo4pvo5pFayYIQpZQj9Yz8a/YrRJCasOvbwP7OVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMeWugGc; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMeWugGc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/65Zqx7dyj5pumyievslN+rp/OnzsN0nXjtq0+bp3mbHsx7FmwfUxL8bTWAaMQLWCpodsq53NXVj7uei1627eWEeX3vIvYM/Asd3LdR+PmMTzg/p57uKr6tThBu04LZTcCvFi6BK8Dtrg96hAxqQT4TGzHViN7rDUM8+37D7miz2IVzDs+nbXw5BbPObFuMaEDg2aJevv/f/h1+Ch3WcrRDjjkkc8VTYwNfQldMrmKl2uTQepLc8jWkqwcgXMkTxp1G7FZOfr6Dg7BkeoF11qvBZlTJxpmQFIF6jbMvYMq/cdvedOmz3U6bsT03A8RDMhowyS2os+30MU+9SyrOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVpqjPK/Ro/GFRsrIztTPQdrqinpLTWyfd/PbTMmJKY=;
 b=bjrsBaVubai3uMtX+9eEdgyDdg0XUSMydsgHdpbqa0wz6pFmoZ21A8Zz+3cEycBuNEwm/rB4MSmh+dERaa1XpqE7EXL1zCYKOydtpwH22WX0DodVU7bVQocnZvu57n9R5CZUqIbgUeuYldTjV2t2MBh3RV71ApyFD/jV0k2nNQM/5ENIImyxRD5ZWmUC00i5OhdAC4v79nbWkqSuDowAK0VBxGnpJKaaFPRFwlxzqHwLlR0lW49Frd3obwyxIxKIqtO8KhCFW9kQYEFym4BVtUsXARvvhlwKKHxMQXpXhf2JOq1ttoBSjZlLar0mZNmMnlFMGHSO6tNEZKw7il6qOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVpqjPK/Ro/GFRsrIztTPQdrqinpLTWyfd/PbTMmJKY=;
 b=mMeWugGcX9ZOX50aFdh8XUrvFK++qx8MeaEjG76tS8oe8pBd8Rc7ETmJFAlntIO/3d9QDojQYmxffTm4cpsUvbxlJZ491KfeHy9tyVv+8JvwJsRW9p9IMYdNECK4uLPaqgIUX1nRRcRECe8eXMXbBCHmy8GmeoxntmSGF3kWSZyqyJTaruZiUo8oIsBVq0765tg53fE9GpkvVIMPTyBiRqmb4TdyrFO8+MPN/vbVQjYbgfvPr9lwbEyeao78A9C0rgPnJlyNLrfWwi2Pup5UzCxnF3Y657oXfxqxnFyi1OfrTgb6qTyNnOBsg6GgC1e0zN4nrhb5gSFPYBX/ouqyIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 21:21:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 21:21:09 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	joel@joelfernandes.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Nikola Djukic <ndjukic@nvidia.com>
Subject: [PATCH v7 03/23] nova-core: Add BAR1 aperture type and size constant
Date: Wed, 18 Feb 2026 16:20:00 -0500
Message-Id: <20260218212020.800836-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218212020.800836-1-joelagnelf@nvidia.com>
References: <20260218212020.800836-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c917c6-af29-4e70-a764-08de6f33a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Pnbw2oEgZBqpdvdhqKX2tiY6U7Ncg3T7SwiFbR3xgT1HZsVHwIJmfizpzf6?=
 =?us-ascii?Q?8EUbuRhd49lqAK7TyTXUi+KuHGkJ/a2IneV23F8ZgXlPlLkYiaCLbZPjQv6X?=
 =?us-ascii?Q?FgirWRTwqrc0WBeyTxTmXqoXTUDTLS/bcehttWTiwcjReUKHG8zG8SDbBkvR?=
 =?us-ascii?Q?tzeGppg/W+aKcWjwQQjk//tpKiUUXt4EcSYpmnzWYS4o1WDYj1XZCw3ujtMp?=
 =?us-ascii?Q?C5m9JTP2SsWEgEx4b8Q09R3ThmAfpSbAWLSRiiT2ga5GsHm39jYCPT/M6sJp?=
 =?us-ascii?Q?MvNk/PfBrPE02ArR0vyelVrQIhVYMD5crysdJtVNT+66OFzRKBImJEDLcTVA?=
 =?us-ascii?Q?vDDEMxFtckVsP1aeAESCE8IEEYLF6fzKoYwLDJnpHedd9cLvkvYlNhcj92F8?=
 =?us-ascii?Q?FI27kM2ISDj45bAHe0y2IuVyj/Nn1DPJjVOw8LNfgOQomAGjQOp21sxVWjLE?=
 =?us-ascii?Q?VWcnT7pW26jPaWJrniBPS1cb/X+Mpc7vdjLTsW+1+NcqMLVt8S3XriHRYQNO?=
 =?us-ascii?Q?LJlg/jjwXqSIn/4BN1tI+tA0uyVPJHIKkksavaSVUV8CPmWx6CsmpHOUcB/o?=
 =?us-ascii?Q?gXBbpwCax7TljjDB9UuzuFoTdmTT79DXMv9X+t6ynzRdCmCk6X/SFPyn2tX5?=
 =?us-ascii?Q?X/ZRbydFMrGEGedgHXEXgwlCLL7l0Mv9WNqcv7DuF6KgNwjflaBl2mNfHK+r?=
 =?us-ascii?Q?tBXlEdOdxyf0pkiLsRl+qTSsQaCfGPEtnNEiKAzU42CoBajBj7jhA4zI7kjF?=
 =?us-ascii?Q?d9sFPm/DceLjdNWD9wxsv5Ku8OewSJrMIrfPr0uaQZCicycWMPYr2gldVRn/?=
 =?us-ascii?Q?icGyfC8po+lVthIovsyULPrdBR5T0fdE4y0RdNizqSujj21EaR7KCubCuVZ2?=
 =?us-ascii?Q?NV8BtTKg10vD0/zaVOK7SXpfNLJwbTUSTbV8hLuPW+gFp3/cxJtIzK8s8YKO?=
 =?us-ascii?Q?9vlJp+fAudM2fU4O4mFSfbdg7e6QzKhwyPDrla6m0/FHeGKxhjX2y8zBBraT?=
 =?us-ascii?Q?2rAbcObn9rOrL+gANU9YBqUzNwl1J37qFP8IZc4yabC4QsrWEiY1V7jpaHlq?=
 =?us-ascii?Q?K+0LSwUlLsnO80OhyI0g3mF910DhhcAoPzzGpk9J8j1R6SF3Q1l/7Y3hf+t6?=
 =?us-ascii?Q?osXL9jpvOJ+oTMIOHvprG14WtCK4y/ql9yn+7ku7hulQO94SZN7IrNdRaLZa?=
 =?us-ascii?Q?AGB553ZYnzV03xImupRdt6fV2acClg1rzbWP0MgjNSls/P8RCtdS+4QMRjKZ?=
 =?us-ascii?Q?ETT8A5JdLYNGFSFcyE83aCoXn5kELjPHetsWcP/EPnnAuG0o980gc+TH+Aot?=
 =?us-ascii?Q?miLBFdN5+kudir9R9zm7MPvico1pDD/x9D6aj4qj+k/00BfLiKBVsj8iqqUi?=
 =?us-ascii?Q?vnjo04/fR0SETsF56snhAXCSRbPP/k29kJChC7NiDKozJikpFkznGFQpZnWn?=
 =?us-ascii?Q?5i8oR3w3QnEWv4JoUW8mC1YyDtu4JMMvKbbLH5YtCkPst68l2gRkMvAUd127?=
 =?us-ascii?Q?MAJWkgEn6cFlGW5QbIrL/UDLXm2Oqjs76FKGu4ngQsnCe5zU8maKLf0vIHor?=
 =?us-ascii?Q?spkM30bUEyiQrZ7HzUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idYcsT6ZJ5ThqgBnfjON0KIOwpcpnGxok2TcIpv+yWxm0pGUMS94tOUHaUVd?=
 =?us-ascii?Q?JgbUweJ2o7jHGGFpxBhkL184cGme/y/HJOMzL0AUoItHmX1LoI5nu+SruKCR?=
 =?us-ascii?Q?loy2QiXNMpXLL4lYo/G10IvDGLBmQ2esmCDWfEYM4IqNFq9fZssbHxXSkpnZ?=
 =?us-ascii?Q?w63j+DYuiOjGflvxNIlI5VYbNu8WskQS6TRsZnQ+dzBgjzEkRBRi75gCSsZg?=
 =?us-ascii?Q?UXXUt4mmvzGKcF3bORiHo3SbslNZD/QKupCNYbpH2HIPpq+kevwhkwq8dNJD?=
 =?us-ascii?Q?4PBLO6aackS8+YU9AvxmgOtcr7PA9byG1UUdzVvDT5UaGT/O3oDCPwWhkeFH?=
 =?us-ascii?Q?9L4wigAelLxajfv2/zPlPG6sVzjyrqAAkmutnARt7IMchd9TEeM2XooY1ST6?=
 =?us-ascii?Q?x2hV0GVSwcOP+m7DmzlHPy4ghHqLpnK4W8He6Lo44z0zH0UnrJUAQQbCyR8N?=
 =?us-ascii?Q?4aYs2/qC3UtVFXP5+HVAlFZYo5/WojduqqAKxXBwksbzmH5LK5s9+ey9wfcY?=
 =?us-ascii?Q?7OIu+6Gw2gvmhcLhXzqCfkF+t7Io2oz5Ih1zHqmgjiO89xuiHton8h+1x3VG?=
 =?us-ascii?Q?tkH/8g6r2kEJKzJ3pB3AScY1QsRvS3aO4hWE7wuPpALsaRv/MzMy62TvBfK6?=
 =?us-ascii?Q?GvVxYfRQu6igJubDb5UeUoXOhTaRIu5yUFjEwhp8wDKKNj9ff7VJXxsya2VF?=
 =?us-ascii?Q?fIiTEabHHxPTrlNry6HGV73mhuP7Nxiz/PJ2qKfrC1rvLn4NmJwX9K16KEd8?=
 =?us-ascii?Q?jGGKUSikPSb4FkfOFmLmseaHuq2AYDyDGfdEL1D+2Ig01HzwLBVZEODDEQXI?=
 =?us-ascii?Q?rnWO5m4HIkh+t9GdIRrkNvO2isdbrFSYpBYiCeL04tfw0lqYsQt5gazazJT7?=
 =?us-ascii?Q?2B0wahWhsin+Nk9PFgT9PXGazBxU3D8bW/c03pcwWoXgzsIT+AYIlIhVKVlz?=
 =?us-ascii?Q?8mbR3aLCg+5pGBbW1jbO+HI3CrRNu4eaeBcDrrV/v+T+R7ni4J1EMUYPOMyV?=
 =?us-ascii?Q?to5dagYp8QSMqP0sXv/B7am//xZPpGpySYzEU0FHLMUC35QaZAzOyRCK0FeW?=
 =?us-ascii?Q?5aN/4hrszO0cjYPTV8T7wkcTx4Ya5v5TTyuE+tXvTV7dZ6aQcXbmwDUBQSZa?=
 =?us-ascii?Q?JzRzr2TEuhXTuXQGSBWHYVwqlLYu/B2LzzNeun/4nMmpMa9ZAFXrSLFnaTRk?=
 =?us-ascii?Q?53E2PRikced9UX9+vCiiHObwSOyd0fVMuJ/P9wNs8JyS6WMw3yGunME2Dv+3?=
 =?us-ascii?Q?fND8JZQJCrwo7Nf/KQWD3L007BNSQ3RX1xu5So5wKhFAM7ftqHhrGyfkLssz?=
 =?us-ascii?Q?DjIkNBfwwGsZeBtgV9ccE1WK8H544JWHw3SVTJONRlIas/WKiVZSE5HkUmZ2?=
 =?us-ascii?Q?0dJA6j4gVEbg6b/Q7vYIlKMPMrtzhahUKEyKv9GCr1YtVtsjedW0PNwe9Vy/?=
 =?us-ascii?Q?GWfMePF6pKwB6Idrjyqr4q5YDMzWGdvpJ26zMo2R9DWzgttV8z03w8EWiVRK?=
 =?us-ascii?Q?XowB01uu+sJWHRb/hPUSdyuqVFDRs7podnX0FNFqc7WXYYbm5ZSvar80uiWm?=
 =?us-ascii?Q?9OQ+w3XjZ0gJmZasFyhy1hLlRJzNlTSicOp52IdskOkrI0BWUL2LyYDu0ZI4?=
 =?us-ascii?Q?Gz1CqganOTCGHR/d87I9Xq6yQ4r6jjFKSWReRcS+mfW9vS0c5OQs3Jm2HXJU?=
 =?us-ascii?Q?CGPfVxMEZ3hVx6Z88P9uEV2EZN2SbehYJZb97+qJfChV9CjjJwOAuXE0smgu?=
 =?us-ascii?Q?3GuOCSNSAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c917c6-af29-4e70-a764-08de6f33a241
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 21:21:09.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzZ/kIRZid3mwGby0Hyw96lxnHWQlHCgxFT9vhRtwSTuNNnkiqR/Q9UO81COkg7lSKhKuqHgLLLdKQTovKguMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111

Add BAR1_SIZE constant and Bar1 type alias for the 256MB BAR1 aperture.
These are prerequisites for BAR1 memory access functionality.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5a4cc047bcfc..d8b2e967ba4c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -13,7 +13,10 @@
         Vendor, //
     },
     prelude::*,
-    sizes::SZ_16M,
+    sizes::{
+        SZ_16M,
+        SZ_256M, //
+    },
     sync::Arc, //
 };
 
@@ -28,6 +31,7 @@ pub(crate) struct NovaCore {
 }
 
 const BAR0_SIZE: usize = SZ_16M;
+pub(crate) const BAR1_SIZE: usize = SZ_256M;
 
 // For now we only support Ampere which can use up to 47-bit DMA addresses.
 //
@@ -38,6 +42,7 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar1 = pci::Bar<BAR1_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
-- 
2.34.1


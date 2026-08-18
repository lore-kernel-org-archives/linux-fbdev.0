Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BF283FC4;
	Tue, 18 Aug 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787014480; cv=none; b=EjNBvnf05HxIiPPzkCTBr5IDWACBMGS6VfA+1lsQB2TQXuGFLBjWhWJjFp79BKS5k0s2eqpt9wNtET6mqfBMH200bGy55Ve3lCoCg7e6IEyyGUSUzyySOa6hbSOL7iJU70gPxec31ZMZy0yjEptBroAqoWX0tcPCc1ttkoaHF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787014480; c=relaxed/simple;
	bh=H3RkmyZa0LX0TWn6eZuoJJNhJAoiEANYxGtp2NGbNWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIfsOEiDft9ddTrFMNCIDptWJj3JcfzUp4AC0I79sthT/Y2lCNZa60kv5Adhen5JYuOGp/a/SVBLYxStc3agGTgQYpjc8mhwNiqDeJCU1ylf8eEY4Fi8DaVcDjsQKnB6baqEb67sj3M7sqEuC02/FZR6qj3AoEcG9LQ7NjlwU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f0f4aba9a9f11f19a56ed5b684f684d-20260818
X-CID-CACHE: Type:Local,Time:202608180848+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5590525d-0ecd-43bb-bdf6-14b92fc9c399,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:73029acdd14f5997fa35d963f8f7ebc8,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f0f4aba9a9f11f19a56ed5b684f684d-20260818
X-User: yuebingkun@kylinos.cn
Received: from tushenkeke2-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yuebingkun@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 353780189; Tue, 18 Aug 2026 08:54:31 +0800
From: yuebingkun <yuebingkun@kylinos.cn>
To: David Laight <david.laight.linux@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
Date: Tue, 18 Aug 2026 08:54:28 +0800
Message-ID: <20260818005428.47917-1-yuebingkun@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153757.4a683d24@pumpkin>
References: <20260817153757.4a683d24@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026, David Laight wrote:
> There is no point using strscpy() to copy quoted strings into arrays.
> Indeed, if the string is too long the kernel build will fail if strcpy()
> is used but strscpy() will silently truncate the strings.
> So strscpy() is actually worse here.

Thank you for the explanation. You are right, for copying a known
string literal into a fixed-size array, strcpy() is actually safer
because the compiler can catch overflow at build time. I will drop
this patch.

---

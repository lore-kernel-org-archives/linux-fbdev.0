Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D636EA99
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049879; cv=none; b=lS1gMgsnzlszsyHwpPrfJngoHBmo3eLVnfXjNgBAUJr+4HSN0W6Y3iOR1SRG6O56BWXGFzG+Wll9zETWA5PonOMoez7JiVjZ+k3+QPAz4OUXQHY+qWXnGAVGOSMJeUo2DyN+n+n9ETEiuF+myId9BgVS5tiyCWFcP9zyDK6E4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049879; c=relaxed/simple;
	bh=/NjYQLUlAQqRHjopFjH8R6wTEBaPvdHffgxnR2Awpdg=;
	h=To:Date:Subject:Message-Id:From:Cc:Mime-Version; b=hbPsLaREC+pt2RExu/NREy+xK3vDFiUyriGmBZCS8UT33nhdXnIaaPfrlHAHKaoLClZP7lktQzkgLv9AQlgsnZkL/6SLhd1eh4poW8foY8sLx3/QbhRAG2BmA60tz/mS1AjrEKBI6N7vfrKZxVj7KAdnJolz/eLUy9qy52x5vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dipeshchaudhary.in; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (2048-bit key) header.d=dipeshchaudhary.in header.i=@dipeshchaudhary.in header.b=gBKbl2rc; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dipeshchaudhary.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipeshchaudhary.in header.i=@dipeshchaudhary.in header.b="gBKbl2rc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipeshchaudhary.in;
 q=dns/txt; s=brevo1; bh=QRHf1dUs5DHSc4cF4HIYieYENyGomrtSGfANHV362tI=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=gBKbl2rc4zo49+t9WIdVJBaxi4jzBF2obk8EifctzZY9n5V+aJ0qIo0LpfBEXeiy1M5sL1fdYKcR
        KwpBP2D4HyBPlRwJ00H1we5DsYfcSwRZsK7XFBaTFJu5OQ1QU/CDr8x7I2sCuFG1McA/RbNmMlpL
        9oE7i2o9noOcu2g3fheApd7fJJNXaBc9n5tAroXvKBoWPBa53Z4DrDzP2DmQkwE1mfJ/pjy7+jv9
        vHWkbQjPI7YEKCUbBuO6nJXitFobQ4rQXNC1ehCotU/RyWebhUNsQzMnVqGRi23t1TEAgLOOxAaG
        US57vX6nf9rskUJwZZdMd5DJJHC+Ic4e+nI30w==
X-CSA-Complaints: csa-complaints@eco.de
To: <sudipm.mukherjee@gmail.com>,<teddy.wang@siliconmotion.com>,<gregkh@linuxfoundation.org>
X-sib-id: cwQc1T0ZnD8TN5v8TRA2xmfANoZUh6Ruqtjkqo-zuqNj-tyRqPGhdytDTwjMtR9kXcUWj3XqtnpLTJvUJqvEM0aHtsL9o5Bb967VE4rQndDnl_iAaAY1Ei4sIEyu4PgUaTthqMuvw3jq_9Lr7xKP9VlkctZUgxPzqPkEDkYSvUpj-w915tdHw7z0
Origin-messageId: <20260309094957.278429-1-me@dipeshchaudhary.in>
X-Mailin-EID: NDQ2MTgxMzU4fmxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZ348MjAyNjAzMDkwOTQ5NTcuMjc4NDI5LTEtbWVAZGlwZXNoY2hhdWRoYXJ5LmluPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  9 Mar 2026 09:49:57 +0000
Subject: [PATCH] staging: sm750fb: constify g_fbmode array
Message-Id: <c9808cbc-a32a-49e7-b666-4b324da95f9f@smtp-relay.sendinblue.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:10551297_-1:10551297:Sendinblue
From: "dipesh chaudhary" <me@dipeshchaudhary.in>
Cc: <linux-fbdev@vger.kernel.org>, <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "dipesh chaudhary" <me@dipeshchaudhary.in>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Fix checkpatch warning for static const char array. Make the array of point=
ers read-only to improve memory safety.

Signed-off-by: dipesh chaudhary <me@dipeshchaudhary.in>
---
 Makefile                        | 6 +++---
 drivers/staging/sm750fb/sm750.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index df471d4212cc..e944c6e71e81 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-VERSION =3D 6
-PATCHLEVEL =3D 19
+VERSION =3D 7
+PATCHLEVEL =3D 0
 SUBLEVEL =3D 0
-EXTRAVERSION =3D
+EXTRAVERSION =3D -rc1
 NAME =3D Baby Opossum Posse
=20
 # *DOCUMENTATION*
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm75=
0.c
index dec1f6b88a7d..08d4979c6755 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor =3D 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] =3D {NULL, NULL};
+static const char * const g_fbmode[] =3D {NULL, NULL};
 static const char *g_def_fbmode =3D "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
--=20
2.47.3




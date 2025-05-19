Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5A2D052;
	Mon, 19 May 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665526; cv=none; b=u5/V+PMyU1tbXpm214uk4KqJemO8Ne4nCltc3pMmlcfRK9+lORgph9jFSjrgIKsKr9CYsElIikxp+qA5K9IaDNOm5AOqDKFEzMXRdhPzvNwtsjTNlfw3znH6/vg1/pH3kEvQauSSkaBtbRImCdIxS+gFlBrBwnRkoF8bDx6B/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665526; c=relaxed/simple;
	bh=yohPNSZ3+uuwk5kSx3Vc2zsHNH3841rz3F4GD5KDd+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XTf7LdmLgXWZp2me9iTY2RVxm7GiJpGr0vnftv++m94ORanqgAHT8V1gRzts2Fs2BDVzZNdnvUltMwU/6tTTcXecoe85aoeO54K5pSNpfEeCvQ4v7yZy3MbYJ1PtjTh/AwNm+RRWrbTrK4xfw/Ln/a0ou0VSkQ9wfyLWdx1UpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blVX0+HU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blVX0+HU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70d70ee042dso6894257b3.2;
        Mon, 19 May 2025 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747665523; x=1748270323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3qOF+M7Ch0i4fooYuNBrA3XOJQM5eyS/FImXYWj+vg=;
        b=blVX0+HUG/TPzxIYQl0kyn9DmrdEOIEWA6ocdDtBq5X5vDWZQaFosBMR1yoxJ56Uu2
         zjfMYFf5oZeAnXZZ9cyGnZ2WduSypNIUFp8ouSix5NSnz/09M3mZYCQxCKyMemhmEpZL
         gvt9g2+7/15NNTTiuVD26NFmiFWKyS6v91dhYTTzS841Klm7C5XFJTn6pTO/bTWn76+2
         9htMIkYoUytTkTJLN9l8Pa+mS61rqtWgmyaQw0sgjgZaZ3O9DlA9UME53nND0q7ABDA4
         suNBWpgQur+K4fRkoVBiMMzldRxG/wBSfYDMli9Ds07+v6aqpHTydhjXsaD+H5Hbw54+
         tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665523; x=1748270323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3qOF+M7Ch0i4fooYuNBrA3XOJQM5eyS/FImXYWj+vg=;
        b=V8PfoLrH7Y6E+DglvRvOuxCwU6bTFsMFSjMgbvA33t0JbTytiBYk14F+w7O1yc5KVR
         /pVehIos4iR6FVT7psAjQvoS2z1A50mKhDFqOZZyWwECRoX5rKmqpxpmt8BDtNEq11E0
         OY/woSPocA+hMZgA9fScnHkdwBfwyTrN37UEE24DF8oP1nolUPvBNbDs99rcDo8Gnfta
         WQOTjICqydBJhLYzKsJJ19gRxuKtP6T7//lGZLwJXUj/Bz/6ZG466gadDv2dhLaKkyIp
         c65wBKtJF1CefuzlahiuZXUeqgv2800amobfXW7/n9N0sZ503KyRkGZHIAsiJO7eW/Ks
         m+4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLGzjsikrllMyvVgui5lhlKQReD/GT1f4UKM4nNcRsWfgyBpdeXQw4GVeD+jWnpcGpBeWnOtE1/us=@vger.kernel.org, AJvYcCX58EPKx583xlmA15FuA/YNmpl/Fkmcvog3DUfx/6F4dYe5kaBP5NTvcKJK4GVH/5Nq+mkPdwCMMbDhqFot@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM9rk+FBfywIHAIveS0qPnhKA6iOq0HPTF3CEFQfqp9bmczi5
	nx/R2gJwMyY6S/5Q08UWCPo+MRw7RYUaMCZc10fpvVyDtuDuKJRarkqPT0yoBi1hY/UrBJX3Bge
	xI08n8/eE7u6kzt78UYNz/QKWnN9x/mJkGg==
X-Gm-Gg: ASbGncu2CrRiFAddkKMYY+QD4eJpoOzsGZ6lFXvSODBXMgg2mLDZX/K5ERpQqYjANW1
	8hdLvS76tof62hvl5oi881xKLNCNzSHpFZoC53AF6rDmAJz0I2+0GNvhTLDKOGyQYqf2ug9bBqw
	Vyvy3zX9GJrLnzYBFB7iy/hn1P9bgsjFDLA1K8+SJXExxuwYyFZJDmMUP1dqPEgc7kO3vYZ9fd5
	Y3W
X-Google-Smtp-Source: AGHT+IFk5/+5g0ye3KpfT6RelFgI8xwRWLH9RkkT7WSS6xIhQSDbLLRhgs5g/GJ0CDL8x9INyAlpDVZv/QVe9HXeDvk=
X-Received: by 2002:a05:690c:4b8f:b0:6f9:af1f:fdd0 with SMTP id
 00721157ae682-70ca7c50638mr193640087b3.31.1747665523438; Mon, 19 May 2025
 07:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: rujra <braker.noob.kernel@gmail.com>
Date: Mon, 19 May 2025 20:08:32 +0530
X-Gm-Features: AX0GCFtZ21KnSBYLwwstp7iu2VM-pnzZgRbPcbW3bS7zlruRQ1KqfAq9Q5Ozqg8
Message-ID: <CAG+54DaA4ni5g26AFKGe76-AgFeMy4GUVopgMQukeaJ_bPWDRQ@mail.gmail.com>
Subject: [PATCH] Documentation : fb : sstfb.rst : Fixed spelling mistake.
To: deller@gmx.de, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fixed document with spelling mistake
changes made :
1. "tweeks" to "tweaks"

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 Documentation/fb/sstfb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/sstfb.rst b/Documentation/fb/sstfb.rst
index 88d5a52b1..6cefa974a 100644
--- a/Documentation/fb/sstfb.rst
+++ b/Documentation/fb/sstfb.rst
@@ -192,7 +192,7 @@ Todo
 - Get rid of the previous paragraph.
 - Buy more coffee.
 - test/port to other arch.
-- try to add panning using tweeks with front and back buffer .
+- try to add panning using tweaks with front and back buffer .
 - try to implement accel on voodoo2, this board can actually do a
   lot in 2D even if it was sold as a 3D only board ...

--
2.43.0

Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD467303A24;
	Tue,  9 Sep 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399883; cv=none; b=rl8zX5pBzi7COm5ciIU3MzOjTeKOfGfOguX/gPvncrUVZjOg7RVgW/CwP/qg5sYHhxADGexbSSKD3CB/SzeAr1VXdFXmKg18fVRSVQ3XhF/0wiyX6BU5WuLA7QX8KPrFaV9tOl3zSjvEBqEGq/Plorf6W4HCwQTtlXGLChT/79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399883; c=relaxed/simple;
	bh=ppPTTyuY/PaFOyKjbTMo6eVL8nyf2NMkBqkAEYcpBFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJn/yqNzNq/hbZCUofXrcuHs9ILoz3qRR+LZ3wp4LB09LBsV7FX+RY52z0Z1onm70EYoDakcsULxnNRUGJlJ7B0elPIwrEELDJ+JNYzQMnWgPNAIZ9NAkGL4B/j3SYHusejjY6KZqg53nM/vPxgpqHgd/C/0nYTlmzGW69dDTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrmofW1j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrmofW1j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24cb39fbd90so44142315ad.3;
        Mon, 08 Sep 2025 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399881; x=1758004681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g270YyKIrBevOK4fPlqJKWoE5PLhUjpLa5PhsUHs33U=;
        b=NrmofW1j1Qytm+pXraKjEzrK/EPrEsxkVK8JxjJJldVQl4EsDjNZM/KESE6GRPNpEW
         kFHWlspJTgmbRo9IkXT6EaZS8HEmf9rBGo/HCO5aoSBxm1hA/l2AXx1frdCiOazvUBFi
         9fW+c/PsuDzDyhwBjVxYCLVJYqluObAabyyPCAh6ZskQfOs+V4GSqouLPoy8977LBYaU
         zm0MRRYu7m5hckpde5XRd7Pdr2a9iXILsalzAblEKrR9Oul2iu9XZl50n7RYJp6PU9WF
         ci4U8beT0qlWozA+uT7Me/70SytyzlmgCZMWGdoQoJ8iT4f4lRaBMcDilI9vVcVt3Z6R
         d2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399881; x=1758004681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g270YyKIrBevOK4fPlqJKWoE5PLhUjpLa5PhsUHs33U=;
        b=dEKtvWTnysMpZkiBbsASvxkC4Bcsn52Leh5omz5w6oB2bWnp2BtynMWOHHv8BQis2S
         pKDS/75Umc0G3FRL5AkYI5aE0a9NF8PwyLJx8qdnMHAttoFdWJ0+rVpaL8Drk3O34zOv
         aenRrzd560nG3XThha8RioTHF0+XPdp55DHKLPFUHe0uuntbgnlQLN9cwEmbB1QD88Iw
         5qUaO/GdJJC5DaUjHBmZRmx6pEaBERHMhJfJdQ3DzNzqKvqFSIm6YMGYnl/B4+p54NW2
         x/q2FvAolXuva7rxiOkm+7M67T+5t9q/vESvSXpPRO2/TlGCBVOYrTDyogx6d3NW7hlt
         SWZw==
X-Forwarded-Encrypted: i=1; AJvYcCWe05dYwBGDixzIpwf9WPSiGXX51B9oRHLGZQbM4dNujmW2Tb0lNJBgIN65+3Qj4DzWj7iroLbM8Ag=@vger.kernel.org, AJvYcCXYTg/I6wZbB842iziOD8ExLz3JH1AfLO9FQj1YpTxk1DPi+eLGlS8MnIVzSRBvMNSDi9c74hzga7xJh6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPS7YPVzTmLOth6sPsOW4WJkGvZbSi2JG9Yv6dtTGiLUGmo/w
	/IthS4Xd31XDsFtUmsPYGeFcMgi1Rp2KLN6BmME5Kjh33wcApZJ92sBu
X-Gm-Gg: ASbGncsSDHw06M0/N+yTn150VNebVrA0rXUxx70tQl+Co6Qtrq/UMzMYHMvY7n+UYSy
	IoXw7O3MyP2rXMFyPSEk32IDUyiShWRJWYP3bUmdnti0fV7OUjyZHhdJn12/Vxtem3933hsRNNI
	VMRzYhRIRlVv1K8Q9JmqOMyJOADkzomoKSxaBmzIs8Gy6MS7mYNkLOOKcfvwz2cU+VrPPDR91o3
	u3H+Sq8K/YsQeCGtxVszd9bckzZzk8N/sSQWQIh1Rf0yC3ocoOiGeKNEP+xM6d5oP6dP512hOW4
	RRjxXLn+gKmWnGXK+eOBG0Pj3epXlR+NK+P7Qa1rqLCICVKe50BFyZEm+qXLVOtuq7cYNWvgcK7
	P8ycHUZzUwh8Z/Rigbbo8S0bAdg==
X-Google-Smtp-Source: AGHT+IE09Vd5suFOpX68LFKhPPmahV9nA3jIm/tqi6CxQ5Yys9D9wYL4f/cGw7U7nLr6pnOmMN+/QA==
X-Received: by 2002:a17:903:2b06:b0:24e:e5c9:ecf7 with SMTP id d9443c01a7336-25170c416ebmr134604565ad.34.1757399881128;
        Mon, 08 Sep 2025 23:38:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25125d76218sm83975455ad.119.2025.09.08.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:37:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6DE6B41F3D84; Tue, 09 Sep 2025 13:37:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] Documentation: fbcon: Use admonition directives
Date: Tue,  9 Sep 2025 13:37:43 +0700
Message-ID: <20250909063744.30053-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909063744.30053-1-bagasdotme@gmail.com>
References: <20250909063744.30053-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=bagasdotme@gmail.com; h=from:subject; bh=ppPTTyuY/PaFOyKjbTMo6eVL8nyf2NMkBqkAEYcpBFk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn7Tx3cOpHbgmdSxvWYfYznAzWz3UsMpW+GRVbrPBbse csR5mfZUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkwrGdk+PeJM2/H+4LOlpen MyzCtwp8WnH11rHXZY3frvL5rr+zS4iRYVn2ZUNf/mNGTaH1m/dNv5edyV52YuqPhb6vk5osJwm v4QQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use reST syntax for admonitions (notes and custom admonition
for gotcha).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/fbcon.rst | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 3ed98b3ce64713..a98a5cb0b0d8bd 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -39,11 +39,13 @@ Also, you will need to select at least one compiled-in font, but if
 you don't do anything, the kernel configuration tool will select one for you,
 usually an 8x16 font.
 
-GOTCHA: A common bug report is enabling the framebuffer without enabling the
-framebuffer console.  Depending on the driver, you may get a blanked or
-garbled display, but the system still boots to completion.  If you are
-fortunate to have a driver that does not alter the graphics chip, then you
-will still get a VGA console.
+.. admonition:: GOTCHA
+
+   A common bug report is enabling the framebuffer without enabling the
+   framebuffer console.  Depending on the driver, you may get a blanked or
+   garbled display, but the system still boots to completion.  If you are
+   fortunate to have a driver that does not alter the graphics chip, then you
+   will still get a VGA console.
 
 B. Loading
 ==========
@@ -117,9 +119,10 @@ C. Boot options
 	outside the given range will still be controlled by the standard
 	console driver.
 
-	NOTE: For x86 machines, the standard console is the VGA console which
-	is typically located on the same video card.  Thus, the consoles that
-	are controlled by the VGA console will be garbled.
+	.. note::
+	   For x86 machines, the standard console is the VGA console which
+	   is typically located on the same video card.  Thus, the consoles that
+	   are controlled by the VGA console will be garbled.
 
 4. fbcon=rotate:<n>
 
@@ -141,10 +144,11 @@ C. Boot options
 	Console rotation will only become available if Framebuffer Console
 	Rotation support is compiled in your kernel.
 
-	NOTE: This is purely console rotation.  Any other applications that
-	use the framebuffer will remain at their 'normal' orientation.
-	Actually, the underlying fb driver is totally ignorant of console
-	rotation.
+	.. note::
+	   This is purely console rotation.  Any other applications that
+	   use the framebuffer will remain at their 'normal' orientation.
+	   Actually, the underlying fb driver is totally ignorant of console
+	   rotation.
 
 5. fbcon=margin:<color>
 
-- 
An old man doll... just what I always wanted! - Clara


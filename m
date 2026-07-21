Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89323644C9
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Jul 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639573; cv=none; b=NPygaRbM1q5qSXmdywIPxsSuqS5I8taFobtA59V2U0IdlT6rCI2J1GwELaW70YjxZSemOfctxBnylRkHyY9SWQX2sT7B3NRnq/mOpp1Z/Ogp8q7cJEUzJ+Yz9Hs9Nd5wNImn6HdcknJdQjuSFc5VCeTqSX3g5Xdv2SyM8KMnyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639573; c=relaxed/simple;
	bh=8s6UjPPxUC+WU+GOlooynAFJu683hzUfQZ1dycjQ1Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSwQgXnv0RPCxqMnet8p6vH7snWo7gu6PiD0EN/fCZqIulUHGgovG548htaRQVmKyoLE9ZH6YW6Fm/A7n7gCWAvpo1loBLweQM8kB4e99Jkj2V4sxl6+1NBVdT6JoHqr7W61lKk7LeW3HVYLmBH2Sr5pkTitsGJAKt8IyLD2FB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UIIIKzaQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UIIIKzaQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47df43bfb07so3091398f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Jul 2026 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639563; x=1785244363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=UIIIKzaQdXj/wSuI9rxoHKcdT4m+FrS2/W3DWg4x0ERUDJ8JkpEoaw/K1i2hgDjR2w
         hMn7mc8BQg1nlERu/mmQ/MSNCSyfjedp/HMsXHjCo7DH0sjX1ATQCKNJQGpSqJPq5kJ7
         Ux9bmfSIrw3XVylRTnk/KAk3SpVn0oXzPDtJNw8t2ROvE15p3/YG8UA7tgpdqREZXnIJ
         6hAC6PK0dfKxCUsXb39JzM15nHddPkD0DIjarqx8wb595uoHyMFlS0kYsg3Yfd9IV6rs
         UxnF+p42wgVkWUp9zq+tbGKaVzOK74iuhYXF5JjuRAX+V3iIkI6ei8M4olzdBwoo9Vzc
         TU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639563; x=1785244363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=kP6WyN6vAplU4awgbHtBAOEh7uArCbO/8ZReTJc72oXzzqWCSn7CQ5ZWmMutapwA8e
         gtArNjJeW3MmCpHWjbj1T2hNW+w21OQ5lxQt/ow5+1adi0nD/08HuQZkx9kvHQmQ3hpJ
         oOk+XwEFqwuqm8C4vvB8TlD2/Zh2kZ8OWA0A1y3s7Lc+f8oB2JqBx3hA+oY/KD7nAHFg
         sjWq/JCA0E1X/Ul51e8u+ROdaZdUaiFSKiNxVegeclqQblE56nDhGdvLJYDj1zt/1Raq
         deawd2ms/FTuv0V1GmkSoIGZfHJj4HT5aHw0nY9mkSwQIU5Axe7Pa+T11P7WxjWoH8j8
         Hjnw==
X-Forwarded-Encrypted: i=1; AHgh+RrS270v91pYeuWrlO7BC0Sjo6TRTt8GB/3eOisXyhMpzW+LD9WaRET4+WoO2mbAvt8CBtsZTa3V0swUpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZcwpeoHydSEj+loOtaYMC+tCDcqT+fbTY9Kz68Jv5GTduJ2w
	C69aDadXY6hPyVbX9FubOtyiOmA4WAmkR2HVH9Jb8r8GhRMyTK1Jmx0v5PplvEKTSdc=
X-Gm-Gg: AR+sD11FQiYhStAL/0bVB99EArDPCX2nocYdkIh2Av/Phfa35iK/4N3v29WYhOtD9BB
	J3S+imicUljIB8biERPiqQiBxBDTfoSHppcbB6/IJMnXFcIYs4pff+RNzhIyk3WQKyS2QUAgFUj
	dXANxyb4ghpHvP0Wikh7aPxUEgO25OvI7PKh8XeU0QByuzqZY0Yy1p3UeOjVFUrzH/qUeF0dqzB
	dtbyQyq2Ff0psHevzP3M67ylO3yuJnvhj300pWAlTT7CQaQhOiv5fD81QfV0Y28Ha9P7m78nHDO
	n8GzRxub/zNgDP16KPom2wn7pTbDBvlGb8z90HIaIQPqxRgVzSX3xuKPyiv0ZESeI3jmSNWtl+C
	7mWPAV/fU3WGEX5FIkCSPYEcwEJ5PbfHo3uY0ObBaeu045w4HJojxhTMSy8hFd8vb7k8lKmO0eA
	==
X-Received: by 2002:a05:6000:4023:b0:47f:81fe:12fb with SMTP id ffacd0b85a97d-47f81fe1712mr2452175f8f.47.1784639562827;
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
Date: Tue, 21 Jul 2026 15:11:26 +0200
Message-ID: <20260721131207.803760-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
currently relies on this header being included indirectly through
linux/module.h -> linux/kmod.h. Add the missing include in preparation for
removing the linux/sysctl.h include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d51428867a33..17cdb5ef8893 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sysctl.h>
 
 #include "timekeeping.h"
 #include "tick-internal.h"
-- 
2.54.0


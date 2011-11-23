From: Sergey Kibrik <sergiikibrik@ti.com>
Date: Wed, 23 Nov 2011 10:29:27 +0000
Subject: Re: [PATCH 35/65] OMAPDSS: APPLY: move spinlock outside the struct
Message-Id: <4ECCCB07.10702@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On 11/22/2011 11:21 AM, Tomi Valkeinen wrote:
> dss_cache struct contains a spinlock used to protect the struct. A more
> logical place for the spinlock is outside the struct that it is
> protecting. So move it there.

a small question: isn't it clearer to keep lock inside struct, so it would be easier to read code? Say, if we meet

> spin_lock_irqsave(&dss_cache.lock, flags);

in code we already aware of what struct being actually protected, and in case of external lock it's not that obvious

-- 
regards,
Sergey

From: Sekhar Nori <nsekhar@ti.com>
Date: Tue, 20 Nov 2012 13:14:54 +0000
Subject: Re: [PATCH] video: da8xx-fb: clk_get on connection id fck
Message-Id: <50AB7F7E.1070400@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/20/2012 6:11 PM, Manjunathappa wrote:
> do clk_get on connection id "fck" to support OMAP based
> platforms having multiple clocks for module. Without this
> driver change clk_get fails on am335x.
> 
> This patch is based on the discussion in community
> http://marc.info/?l=linux-kernel&m5166018907827&w=2
> 
> Signed-off-by: Manjunathappa <prakash.pm@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>

For the mach-davinci changes:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Florian,

I assume you will want to take this through your tree?

Thanks,
Sekhar

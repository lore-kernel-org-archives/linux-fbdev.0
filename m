From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 21 Mar 2011 16:41:56 +0000
Subject: Re: [PATCH 07/20] video: msm: Allow users to request a larger x
Message-Id: <20110321164156.GF4340@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485381-27201-1-git-send-email-carlv@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB033D22EAE7@dbde02.ent.ti.com>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033D22EAE7@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 21, 2011 at 10:10:09AM +0530, Janorkar, Mayuresh wrote:
> > +	fix->line_length = var->xres * var->bits_per_pixel / 8;
> Why to divide by 8? Atleast use >>3, bitwise operations that would take
> less cpu cycles)
> As I stated earlier define a new macro for var also.

Modern compilers know about such things.  >> 3 vs / 8 (probably) makes no
difference to the generated code with the toolchains we use.

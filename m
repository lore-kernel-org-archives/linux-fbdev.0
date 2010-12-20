From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:00:01 +0000
Subject: Re: [PATCH 1/2] fbdev: Minor cleanup in WM8505-related code
Message-Id: <20101220160001.GD26766@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101219181300.GA32645@alchark-u3s> <EAF47CD23C76F840A9E7FCE10091EFAB0322F86AE6@dbde02.ent.ti.com> <20101220130314.GA3627@alchark-u3s>
In-Reply-To: <20101220130314.GA3627@alchark-u3s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Charkov <alchark@gmail.com>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vt8500-wm8505-linux-kernel@googlegroups.com" <vt8500-wm8505-linux-kernel@googlegroups.com>

On Mon, Dec 20, 2010 at 04:03:14PM +0300, Alexey Charkov wrote:
> This replaces the last remaining driver name reference with the
> macro for uniformity in wm8505fb.
> 
> In addition, the error return path in wmt_ge_rops.c is made more
> uniform by getting rid of goto's in remaining places.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

I'll hold on to this for .38, as there's nothing really pressing here.

From: Joe Perches <joe@perches.com>
Date: Sat, 25 Nov 2017 21:38:41 +0000
Subject: Re: [PATCH 2/2] staging: sm750b: Fix coding style issues in sm750_accel.c
Message-Id: <1511645921.2503.18.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125182636.15245-1-j.lacomis@gmail.com>
         <20171125182636.15245-2-j.lacomis@gmail.com>
In-Reply-To: <20171125182636.15245-2-j.lacomis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Lacomis <j.lacomis@gmail.com>, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, 2017-11-25 at 13:26 -0500, Jeremy Lacomis wrote:
> This is a patch to sm750_accel.c that fixes 80-character line length
> warnings found by checkpatch.pl. It also fixes some grammatical errors
> in comments and moves parameter-specific comments from inline to before
> the function.
[]
> + * Notes on these parameters:
> + *         sBase: Address of the source offset in the frame buffer
> + *         sPitch: Pitch value of the source surface in BYTE
> + *         sx, sy: Starting coordinate of the source surface
> + *         dBase: Address of the destination offset in the frame buffer
> + *         dPitch: Pitch value of the destination surface in BYTE
> + *         Bpp: Color depth of the destination surface
> + *         dx, dy: Starting coordinate of the destination surface
> + *         width, height: Dimensions of the rectangle in pixels
> + *         rop2: ROP value

Use kernel-doc format instead.


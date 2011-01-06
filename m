From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 06:55:39 +0000
Subject: Re: [PATCH 1/2] Cleaning up modedb file
Message-Id: <20110106065539.GG15340@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB03232B6B12@dbde02.ent.ti.com>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB03232B6B12@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jan 03, 2011 at 04:31:38PM +0530, Janorkar, Mayuresh wrote:
> A part of file: drivers/video/modedb.c was not as per the coding guidelines.
> 
> The cleanup includes:
> 1) Converting spcaes to tabs
> 2) Adding spaces on either sides of "|" operator
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
>  drivers/video/modedb.c |  316 ++++++++++++++++++++----------------------------
>  1 files changed, 134 insertions(+), 182 deletions(-)
> 
The irony here is that your mailer has in turn converted your tabs back
to spaces, so it doesn't apply. :-)

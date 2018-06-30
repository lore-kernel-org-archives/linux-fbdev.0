From: Timur Tabi <timur@kernel.org>
Date: Sat, 30 Jun 2018 15:59:15 +0000
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
Message-Id: <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180629184655.GA37391@beast>
In-Reply-To: <20180629184655.GA37391@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 6/29/18 1:46 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this moves
> the buffer off the stack (since it could be as much as 1024 bytes), and
> uses a new area in the cursor data structure. Additionally adds missed
> documentation and removes redundant assignments.
> 
> [1]https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook<keescook@chromium.org>

Acked-by: Timur Tabi <timur@kernel.org>

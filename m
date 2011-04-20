From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 20 Apr 2011 09:25:00 +0000
Subject: Re: [PATCH] efifb: Fix "cast to pointer from integer of different size"
Message-Id: <20110420092500.GD15898@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1303245483-2799-1-git-send-email-mikew@google.com>
In-Reply-To: <1303245483-2799-1-git-send-email-mikew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <mikew@google.com>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 19, 2011 at 01:38:03PM -0700, Mike Waychison wrote:
> Fix set_system() to not cause a cast warning when printing a u32 as a
> pointer:
> 
> drivers/video/efifb.c: In function 'set_system':
> drivers/video/efifb.c:247: error: cast to pointer from integer of
> different size
> 
> Allow the integer to print as a pointer by first casting to unsigned
> long which we know will be the width of a pointer and at least as wide
> as u32.
> 
> Signed-off-by: Mike Waychison <mikew@google.com>

I've already taken another patch that fixed it a slightly different way,
thanks anyways.

From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 03:30:15 +0000
Subject: Re: [PATCH 3/3] fbcon: fix situation where fbcon gets deinitialised and can't reinit.
Message-Id: <20101224033015.GJ28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292895677-4242-1-git-send-email-airlied@gmail.com> <1292895677-4242-4-git-send-email-airlied@gmail.com>
In-Reply-To: <1292895677-4242-4-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>

On Tue, Dec 21, 2010 at 11:41:17AM +1000, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> Situation as follow:
> 2 GPUs + vesafb + kms.
> 
> GPU 1 is primary, vesafb binds to it as fb0
> radeon loads
> GPU 0 loads as fb1
> GPU 1 loads, vesafb gets kicked off which causes fb0 to unbind
> console, which causes the dummy console to rebind.
> 
> this means fbcon_deinit gets called, which calls fbcon_exit
> since the console isn't bound anymore and we set fbcon_has_exited.
> 
> GPU 1 creates a new fb0 which is primary and we want to be console.
> fbcon_fb_registered gets called sets the primary up and calls set_con2fb_map,
> however as fbcon_has_exited is set nothing further ever happens.
> 
> This patch bypasses the fbcon_has_exited and checks if the console is unbound,
> if its unbound it calls the fbcon_takeover which calls the vt layer to
> call the fbcon_startup method and everthing works.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>

This one looks fine, too. This does presumably depend on the change in
behaviour introduced by your 2/3 patch though. I'll hold off on applying
this until that one gets acked, then we can do this either for the next
-rc or for .38.

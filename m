From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Mar 2019 08:03:02 +0000
Subject: Re: [PATCH 02/11] drm/fbdevdrm: Add fbdevdrm device
Message-Id: <CAKMK7uE2H48kwJCAAm-8a9e7WF4Au2Cuv7g0wy2UOzcvY8BBHg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-3-tzimmermann@suse.de>
 <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>
 <a0697626-dc39-702e-3850-def8cbc71508@suse.de>
In-Reply-To: <a0697626-dc39-702e-3850-def8cbc71508@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Mar 27, 2019 at 8:55 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> This all comes from using the event-reporting mechanism to hook into the
> fbdev module. Daniel suggested to copy over some of the fbdev drivers
> for porting, which would solve the problem.

On the fbdev event reporting stuff: I have a patch series to remove
that, and replace the fbdev->fbcon interactions with direct function
calls. The locking in the notifier is a serious pain. I guess that
would be another detail we'd need to change, if we go with this
approach here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/i915: fixup per-crtc locking in
	intel_release_load_detect_pipe
Date: Thu, 24 Jan 2013 10:55:12 +0100
Message-ID: <20130124095512.GU31870@phenom.ffwll.local>
References: <1358958309-5342-1-git-send-email-daniel.vetter@ffwll.ch>
	<1358958309-5342-3-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1358958309-5342-3-git-send-email-daniel.vetter@ffwll.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Wed, Jan 23, 2013 at 05:25:09PM +0100, Daniel Vetter wrote:
> One of the early return cases missed the mutex unlocking. Hilarity
> ensued.
> 
> This regression has been introduced in
> 
> commit 7b24056be6db7ce907baffdd4cf142ab774ea60c
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Wed Dec 12 00:35:33 2012 +0100
> 
>     drm: don't hold crtc mutexes for connector ->detect callbacks
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=59750
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Tested-by: Cancan Feng <cancan.feng@intel.com>

Dave, please pick this one up for your drm-next tree since the issue only
happens there due to the modeset locking rework.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

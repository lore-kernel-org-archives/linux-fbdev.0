From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/2] fbcon+i915 locking fixes
Date: Wed, 23 Jan 2013 17:25:07 +0100
Message-ID: <1358958309-5342-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

Hi Dave,

First patch is a resend of Alan's fbcon vs. fb notifier deadlock fix.
Without this lockdep is pretty much useless for debugging drm locking
issues, and it looks like quite a few bootup hangs could be blamed on this
one, too.

Since the fbdev maintainer seems to be awol, please merge this through
your drm tree. I've looked through the patch and the new locking seems to
be sane so feel free to smash a

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

onto it.

2nd patch is a locking bug in the i915 driver with the new kms locking.
Since the bug only happens in your drm-next tree, please apply the patch
there directly.

Thanks, Daniel

Alan Cox (1):
  fb: Rework locking to fix lock ordering on takeover

Daniel Vetter (1):
  drm/i915: fixup crtc locking in intel_release_load_detect_pipe

 drivers/gpu/drm/i915/intel_display.c |    1 +
 drivers/tty/vt/vt.c                  |   81 ++++++++++++++++++++++++++--------
 drivers/video/console/fbcon.c        |   30 ++++++++++++-
 drivers/video/fbmem.c                |    5 +--
 drivers/video/fbsysfs.c              |    3 ++
 include/linux/console.h              |    1 +
 6 files changed, 98 insertions(+), 23 deletions(-)

-- 
1.7.10.4

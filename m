From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/3] DRM/KMS framebuffer fixes
Date: Mon, 02 Nov 2009 08:40:13 +0100
Message-ID: <4AEE8CDD.10600@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754025AbZKBHkM@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

These patches make the KMS framebuffer work with various programs like
links, mplayer and X.

 drivers/gpu/drm/drm_fb_helper.c    |    6 +++---
 drivers/gpu/drm/i915/intel_fb.c    |    5 +++++
 drivers/gpu/drm/radeon/radeon_fb.c |    5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

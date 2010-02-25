From: Dave Airlie <airlied@gmail.com>
Date: Thu, 25 Feb 2010 04:44:25 +0000
Subject: fb fix + laptop gpu switching support
Message-Id: <1267073067-23117-1-git-send-email-airlied@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

The first patch is a trivial change to the fb handover code.

The second adds initial support framework for laptops with GPU switching
features, it has some changes to fb code, along with changes to dri
drivers.

I'm happy to deal with these patches via drm-2.6 for this merge window
if nobody has any objections.

Dave.


From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 20 Feb 2010 23:10:49 +0000
Subject: [Patch 0/3] backlight
Message-Id: <20100221001049.2f63f5d6@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This series improves backlight_ops's check_fb function, marks
backlight_ops as const and fixes error checking when registering
backlight device.

Bruno

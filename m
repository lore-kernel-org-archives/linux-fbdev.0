From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27] AM300 kit support
Date: Tue,  4 Nov 2008 08:55:08 +0800
Message-ID: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org

Hi Eric, Dmitry, Geert, Krzysztof, lak, input, fbdev,

This is my first pass at adding support for things on the AM300 kit from
E-Ink. The main two new things are the Wacom w8001 support and the
AM300/broadsheetfb display support. The other 3 patches are for cleanup.

There are still issues I intend to debug (latency on the display, usb
issues) but will lose access to the hardware for a while so this seems like
a good point to post the code. I would greatly appreciate your feedback.

Thanks,
jaya



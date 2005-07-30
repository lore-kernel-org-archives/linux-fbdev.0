From: Andrey Volkov <avolkov@varma-el.com>
Subject: Where is place of arch independed companion chips?
Date: Sat, 30 Jul 2005 15:52:50 +0400
Message-ID: <42EB6A12.70100@varma-el.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263050AbVG3LxN@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: gregkh@suse.de, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Greg,

While I write driver for SM501 CC (which have graphics controller, USB
MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
I bumped with next ambiguity:
Where is a place of this chip's Kconfig/drivers in
kernel config/drivers tree? May be create new node in drivers subtree?
Or put it under graphics node (since it's main function of this CC)?

AFAIK, this is not one such multifunctional monster in the world, so
somebody bumped with this problem again in future.

-- 
Regards
Andrey Volkov

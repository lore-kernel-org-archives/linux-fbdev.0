From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 10 May 2010 17:56:36 +0000
Subject: Re: viafb suspend & resume, v2
Message-Id: <20100510195636.7936ec76@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net

On Sun, 02 May 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> This is the second version of this patch series. It is forward ported to apply
> on Jon's current viafb-posted branch. Furthermore the engine is only
> (re)started if the mmio space is mapped.
> There are still issues left especially device configuration and it does not yet
> integrate nicely in the new structure of the driver. However it is in a state
> where it shouldn't hurt anyone but could be useful for some people.

Only works with restrictions on my box.

System is Commell LE-365, 1GB RAM, lspci:
00:00.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:0324] (rev 03)
00:00.1 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:1324]
00:00.2 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:2324]
00:00.3 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:3324]
00:00.4 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:4324]
00:00.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:7324]
00:01.0 PCI bridge [0604]: VIA Technologies, Inc. VT8237/VX700 PCI Bridge [1106:b198]
00:0f.0 IDE interface [0101]: VIA Technologies, Inc. CX700/VX700 RAID Controller [1106:0581]
00:10.0 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller [1106:3038] (rev 90)
00:10.1 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller [1106:3038] (rev 90)
00:10.2 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller [1106:3038] (rev 90)
00:10.4 USB Controller [0c03]: VIA Technologies, Inc. USB 2.0 [1106:3104] (rev 90)
00:11.0 ISA bridge [0601]: VIA Technologies, Inc. CX700/VX700 PCI to ISA Bridge [1106:8324]
00:11.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Internal Module Bus [1106:324e]
00:13.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge [1106:324b]
00:13.1 PCI bridge [0604]: VIA Technologies, Inc. CX700/VX700 PCI to PCI Bridge [1106:324a]
01:00.0 VGA compatible controller [0300]: VIA Technologies, Inc. CX700/VX700 [S3 UniChrome Pro] [1106:3157] (rev 03)
02:08.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet [10ec:8169] (rev 10)
80:01.0 Audio device [0403]: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA High Definition Audio Controller) [1106:3288] (rev 10)


If I have accel enabled system freezes during suspend, if accel is disabled
system suspends&resumes.
From a quick glance at the code I don't know what to do to disable accel
during suspend (and restore it on resume)...

viafb is not able to get GPU alive from its own, it still needs to have the
BIOS run VBIOS on resume.

Thanks,
Bruno

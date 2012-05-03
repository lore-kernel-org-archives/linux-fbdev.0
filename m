From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Thu, 03 May 2012 21:58:35 +0000
Subject: Re: [PATCH v2] video/sis: Use SiS_DRAMType from init.h and annotate it __devinitconst
Message-Id: <201205032358.36229.PeterHuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FA2FD10.6090306@gmx.de>
In-Reply-To: <4FA2FD10.6090306@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Donnerstag 03 Mai 2012, 23:48:00 schrieb Florian Tobias Schandinat:
> You can still mark it as __devinitconst, I just wanted to have the array
> inside a C file, not a header. If you agree with this, I'll change your
> new patch that way.
I'm totally fine with this - Thanks,
Peter

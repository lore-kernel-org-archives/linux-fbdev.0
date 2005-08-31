From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 09:14:50 +0800
Message-ID: <4315048A.1020907@gmail.com>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932321AbVHaBPQ@vger.kernel.org>
In-Reply-To: <43149E5B.7040006@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>, Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> fb_pad_aligned_buffer() is also slower for those cases. But does anybody
> use such fonts?

Yes, there are 16x30 fonts out there in the wild. 

Tony

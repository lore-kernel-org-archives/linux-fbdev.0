From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Geode patches for 2.6.17
Date: Fri, 23 Jun 2006 15:07:12 -0600
Message-ID: <20060623210712.GE13017@cosmic.amd.com>
References: <20060623170058.GA12819@cosmic.amd.com>
 <1151088069.4549.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752052AbWFWVCz@vger.kernel.org>
In-Reply-To: <1151088069.4549.72.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On 23/06/06 19:41 +0100, Alan Cox wrote:
> Ar Gwe, 2006-06-23 am 11:00 -0600, ysgrifennodd Jordan Crouse:
> >       Add a configuration option to avoid automatically probing VGA
> 
> Can you not do this automatically using the DMI data or PCI subvendor
> id ?

This option actually disables VGA probing kernel wide - it essentially 
skips all of video.S during boot, and then disallows any drivers that may
depend on that data (VGA console being the prime example).

While I am about 85% sure that probing the missing VGA/VESA registers will 
not cause any problems, the values read will be nonsense, and I wanted to 
avoid the possibility that any part of the code will blindly use the 
returned data without checking it. 

The option is triggered off of EMBEDDED, and I felt it would be buried 
deep enough to not cause heartburn to the casual user.

Jordan 

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 19:58:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <9e47339104101516585e590a6d@mail.gmail.com>
References: <200410160551.40635.adaplas@hotpop.com>
	 <9e47339104101516206c8597d3@mail.gmail.com>
	 <416FFFFD.28877.2F2B6C9@localhost>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267678AbUJOX6L@vger.kernel.org>
In-Reply-To: <416FFFFD.28877.2F2B6C9@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <kendallb@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, 15 Oct 2004 16:51:09 -0700, Kendall Bennett
<kendallb@scitechsoft.com> wrote:
> I have not used initramfs at all (I am not sure I know what it is
> actually) so I don't know. I know there is quite a long period of time on
> most machines from when the kernel starts booting and when the real file
> system based init process takes over.

initramfs/initrd comes up very early in the boot process. For example
it holds your supplemental device drivers and initial /dev.
/dev/console is opened from this /dev so it much be up before the
console is. This is much earlier than normal user space starts.

I believe the current Fedora 3 uses udev from initramfs, but I haven't
tried it yet.

-- 
Jon Smirl
jonsmirl@gmail.com

From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 11:34:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031024183405.36600.qmail@web14915.mail.yahoo.com>
References: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

PCI ROM enabale/disable has come up before on LKML. Russell made this comment
about making the code more portable.

--- Russell King <rmk@arm.linux.org.uk> wrote:
> You should use pcibios_resource_to_bus() to convert a resource to a
> representation suitable for a BAR.

http://lkml.org/lkml/2003/8/19/279


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
Date: Thu, 23 Mar 2006 21:06:16 +0800
Message-ID: <44229D48.6040502@gmail.com>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932462AbWCWWHM@vger.kernel.org>
In-Reply-To: <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sylvain.meyer@worldonline.fr, akpm@osdl.org

Dave Airlie wrote:

> laptop users with these chipsets, getting DVI working is a bit more
> work as there are external chips that need to be driven over i2c, so
> I'll need to at least add i2c support to the i8xx driver. (I noticed
> Sylvain has done some of this work before)..... I'd like to expose i2c
> buses to userspace anyways....

Someone mentioned (I think it was Nicholas Boichat) that the i2c code
of i810fb works for intelfb too, but I cannot verify that.

Tony

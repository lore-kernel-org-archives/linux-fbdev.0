From: Otto Solares <solca@guug.org>
Subject: Re: FBDEV updates.
Date: Thu, 14 Aug 2003 14:36:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030814203658.GE7862@guug.org>
References: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Aug 14, 2003 at 08:54:21PM +0100, James Simmons wrote:
> 
> Hi folks!!
> 
>   Here is the latest fbdev BK drop. It is against 2.6.0-test3. Test it out 
> and tell me your results. I like to do a code drop soon. 

James:

what is the current state of PM in fb drivers?

does modedb is being used on 2.6 drivers?

Is there an API (or lib) to use framebuffers devices without
worring about differents visuals?, to quering, setting or
disabling EDID support? will these drivers export sysfs
entries instead of control via ioctl's?

thanks for your work on fb.

-solca

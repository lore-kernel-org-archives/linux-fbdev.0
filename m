From: Ben Collins <bcollins@debian.org>
Subject: Re: New fbdev updates.
Date: Thu, 3 Jul 2003 19:50:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030703235039.GB502@phunnypharm.org>
References: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 03, 2003 at 06:55:58PM +0100, James Simmons wrote:
> 
> Hi!
>    
>    I have updates to the framebuffer layer. Alot of bug fixes accumlated. 
> A couple of driver updates as well. I have more code to go in but haven't 
> had time to add them in. Please test. This is not the final code going in 
> just yet. More needs to be done. The patches are at the usual

Seems my old corrupt cursor is fixed, but with your new code I am
getting ghost cursors left behind while moving around in vim over ssh
with syntax on.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 15:55:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4E5C514B42@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On  3 Apr 03 at 15:48, Sven Luther wrote:
> 
> Ideally, the EDID reading would be done just after the user request an
> output mapping change for the first time, and then stored privately to
> each output. mode changes and such would be done after the output has
> been assigned only, and you would have the EDID by then. You could even
> reread it regularly, in case the monitor is hot swapped or something such.

Read is not enough. If you have connected one /dev/fbx to two monitors,
you must find highest common denominator for them, and use this one.
                                                                Petr
                                                                

From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 09:39:08 -0800
Message-ID: <200503080939.09306.jbarnes@engr.sgi.com>
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de> <422D3155.9000102@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <422D3155.9000102@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: chaosite@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Monday, March 7, 2005 9:00 pm, Matan Peled wrote:
> Arnd Bergmann wrote:
> > Nothing about the init command seems really necessary. Why not just do
> > that stuff from an /sbin/init script?
>
> I'm not a kernel hacker by any definition, but I'm pretty sure its
> neccasery because we want it to be done before /sbin/init is ran, AKA hide
> the kernel messages :)

You can already hide the kernel messages by booting with the 'quiet' option.  
It works pretty well and it seems like this stuff should be in userspace 
anyway (console support in general that is).

Jesse

From: Joe Perches <joe@perches.com>
Date: Wed, 17 Jun 2015 08:20:34 +0000
Subject: Re: [PATCH 7/8] staging: sm7xxfb: move mode table
Message-Id: <1434529234.2689.69.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <1434462131-15191-7-git-send-email-sudipm.mukherjee@gmail.com>
	 <1434476037.2689.1.camel@perches.com> <20150617081522.GB13043@sudip-PC>
In-Reply-To: <20150617081522.GB13043@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, 2015-06-17 at 13:45 +0530, Sudip Mukherjee wrote:
> On Tue, Jun 16, 2015 at 10:33:57AM -0700, Joe Perches wrote:
> > On Tue, 2015-06-16 at 19:12 +0530, Sudip Mukherjee wrote:
> > > move vgamode table from the header file to the C file and mark it
> > > as const.
> > 
> > The slightly odd indentation could be fixed here too.
> Ok. I am sending v2. But if I am reviewing it I will say
> "you are doing too many things in one patch" :( .
> so i will fix the indention the other patch which is fixing indention.

You could send a follow-up patch to fix it rather than send
a v3 of everything.

cheers, Joe


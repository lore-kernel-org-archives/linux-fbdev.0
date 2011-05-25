From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 25 May 2011 18:51:05 +0000
Subject: Re: [PATCH] fbmem: fix race condition between
Message-Id: <20110525205105.03e2d911@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
	<BANLkTi=Q5EzN+wP9jDNCxCnZBQ0XHOmOhQ@mail.gmail.com>
	<BANLkTikk2BbOWHQN+UPWD71QoM6g-QpHZg@mail.gmail.com>
In-Reply-To: <BANLkTikk2BbOWHQN+UPWD71QoM6g-QpHZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Erculiani <lxnay@sabayon.org>
Cc: Anca Emanuel <anca.emanuel@gmail.com>, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
> On Wed, May 25, 2011 at 8:41 PM, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> >
> > Did you test 2.6.39 ? The fix from Linus is not ok ?
> >
> 
> Sorry, maybe I missed it?

Your patch was against 2.6.39 or shortly before as Linus's code
did introduce the do_ variants of register/unregister/conflict functions.

Bruno

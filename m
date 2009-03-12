From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Thu, 12 Mar 2009 17:19:13 +0200
Message-ID: <46e1c7760903120819s6f1c6695keba84d4315790e36@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <20090211142409.b88c577e.akpm@linux-foundation.org>
	 <46e1c7760902121312o1476e734xc1fc1d6e11ce4d2e@mail.gmail.com>
	 <20090213210635.d094ffc8.krzysztof.h1@poczta.fm>
	 <20090222081517.567a29bd.krzysztof.h1@poczta.fm>
	 <46e1c7760902220125l61700421gc4045ca10ea4dd10@mail.gmail.com>
	 <20090222164052.dd5442c4.krzysztof.h1@poczta.fm>
	 <46e1c7760902222253p34a714bao5c06b0ad4d779337@mail.gmail.com>
	 <20090228195143.03b1f600.krzysztof.h1@poczta.fm>
	 <46e1c7760903010350i42d84257lc82c492139607bb8@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756610AbZCLPT3@vger.kernel.org>
In-Reply-To: <46e1c7760903010350i42d84257lc82c492139607bb8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: adaplas@pol.net, Andrew Morton <akpm@linux-foundation.org>, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Now I have changed the graphics card on my PC to 3dfx voodoo 3
(tdfxfb), and indeed it made a difference: no cursor. So it begins to
look like the problem only exists on atyfb.

Risto

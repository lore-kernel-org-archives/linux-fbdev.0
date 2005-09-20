From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Date: Tue, 20 Sep 2005 08:20:48 +0800
Message-ID: <432F55E0.70304@gmail.com>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964795AbVITAVX@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jan Dittmer <jdittmer@ppp0.net>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>

James Simmons wrote:
> the hwcur module parameter is set to off by default. Should it be removed?
> 

The hardware cursor for newer chipsets (NV20 and above?) is not very
nice to the eyes.  When the cursor is moved, the old cursor image does
not disappear immediately, but kinda fades away.  I believe it is an
nvidia special effect for mouse pointer trails. Cool when in graphics, but
irritating when in text mode.

So, no, let's leave hwcur to 0.

Tony

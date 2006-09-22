From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: backlight: oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/* in 2.6.18
Date: Sat, 23 Sep 2006 01:07:55 +0200
Message-ID: <20060922230755.GA9548@hansmi.ch>
References: <20060921121952.GA16927@aepfle.de> <20060921123742.ec225cc2.akpm@osdl.org> <20060921215620.GA9518@hansmi.ch> <20060922112622.GA26724@aepfle.de> <20060922160255.b97f2887.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964905AbWIVXH6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060922160255.b97f2887.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, Daniel R Thompson <daniel.thompson@st.com>, Jon Smirl <jonsmirl@gmail.com>

On Fri, Sep 22, 2006 at 04:02:55PM -0700, Andrew Morton wrote:
> Still looks like a bit of a mess, but I assume that's expected.

> Michael, I take it that patch was final?

For now, yes. Thanks for adding it to -mm.

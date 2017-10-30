From: Timo Ketola <timo@exertus.fi>
Date: Mon, 30 Oct 2017 08:11:51 +0000
Subject: Backlight confusion
Message-Id: <81af4f35-15ff-91e1-828c-aee716dfdc5c@exertus.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I'm confused.

There is a commit 8c16f3303c34 in linux-stable. Its idea is to reduce
calls to low level backlight drivers. But what happens now, at least in
my case, is that on first blank event after boot bd->fb_bl_on[node] is
false, backlight_update_status is not called and backlight is left on.
As I understand it all FBs must change their state at least once before
backlight driver is completely synced with framebuffers.

I don't understand how is this supposed to work. I could initialize
fb_bl_on and use_count for the initial state where FBs are unblanked but
then backlight driver had to know how many backlights there are. I have
not found any hints how other drivers might solve this.

Could anybody enlighten me in my confusion?

--

Timo

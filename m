From: Daniel Drake <dsd@laptop.org>
Date: Thu, 17 Nov 2011 16:24:36 +0000
Subject: Recent viafb changes break OLPC DCON freeze
Message-Id: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

The OLPC XO-1.5 has a display controller (dcon) which is able to drive
the display while the video device is powered off (e.g. while the
system is in suspend). It works on demand, (approximately) by grabbing
the latest displayed picture (at the hardware level), storing it in
dedicated DCON RAM, and continually reproducing it on the screen. This
is known as "DCON freeze" and can also be triggered while the video
device is still running by executing:

echo 1 > /sys/devices/platform/dcon/freeze
(enabled by CONFIG_FB_OLPC_DCON_1_5)

Unfortunately this has broken in recent kernels due to viafb changes:
when going into "DCON freeze", the DCON fails to capture the display
contents and instead displays garbage. I am testing this on viafb
outside of X.

There are some complications in debugging this and pinpointing a
single responsible commit.

Kernels v2.6.38 and previous work fine. However, in such kernels, OLPC
included an out-of-tree DCON driver. 2.6.38 includes a DCON driver (in
staging) but it was not usable at this point.

v2.6.39 has a functional DCON driver, but viafb in this kernel is
unusable on XO-1.5 due to an unrelated bug which only got fixed for
3.0:
http://www.spinics.net/lists/linux-fbdev/msg03132.html

v3.0 and onwards reproduces the failure.

To debug this, I took the approach of starting with 2.6.38, fixing the
DCON driver in that old kernel, then going through the viafb changes
until the point of breakage was found. This can be done as follows:

git reset --hard v2.6.38

First, fix the DCON driver:

git cherry-pick a90dcd4f7dfc3e664e7d08790a8b39d052e21a2e
git cherry-pick e107e6ebdda9b56be21951a7c58c2fa90d6e685b
git cherry-pick fe2d5b43807ebb38e0e8c7b269ff08fcd4011726
git cherry-pick 8d2d3dd1b4589299ec17b15130fbadfc69996df4
git cherry-pick bb4103544e455e11d9a4379326406a60429b9888
git cherry-pick bada46e5ab10b09b0f86e8b8ede009e759a16adf
git cherry-pick 56463de05a56b80b43d21a442cf2a6e0037762e8
git cherry-pick 9ed62423033d167765a2c6385064acbeeadb2b14
git cherry-pick feaa98b2a5e452d95624d3f217cf1aab9cd25db0
git cherry-pick 45bfe97276856b866dd73fdadb65fb928c0c9bc1
git cherry-pick 31a3da4146c120e87b8d42d033760fe49704a233
git cherry-pick 8f2fb16a9cd015072b3da9038084930287e11985
git cherry-pick 097cd83a4c312e1ae0d9c14526f846666cab4f3a
git cherry-pick bbe963f1b98c90980e33086d726f0963e286d1b4
git cherry-pick 309ef2a25e8d3d5962bb0824c58ea39c12c166ef
git cherry-pick c59eef17f1cc21a984cf077ad45a8355781881b6
git cherry-pick b07b846c333708ce2b95b5cd2a86f51a74331d02
git cherry-pick 6a3a81e7ca9b1ddaaf8d644b4102aff0fe2a7c40
git cherry-pick bed4ab7781e8600a7ebf4378a1b3f26d31517f57

The dcon functionality can now be tested (it works).

Then we can apply all of the viafb changes between 2.6.38 and 2.6.39,
one by one until the commit prior to the one that completely broke
XO-1.5 video:

git cherry-pick a625e305edd8e3ac08888a9b52981205b68cdb0e
git cherry-pick b65d6040e3a7cd75d9287f7ddfd115e85fde4b44
git cherry-pick 23e5abd5555b86fd56af6383e7a832b0cf2a2d95
git cherry-pick dbf85f2326dbb070256ff153853b00f70c27717a
git cherry-pick c8350be26237e2b850b9611dbe55304ad6ebc6c7
git cherry-pick d90108765b64e39e88e59f51d05ac652f0e53fea
git cherry-pick bf5ea02d9058a97a0bc2da9ca04ae4b34989407a
git cherry-pick f5b1c4b3b6d407ec5a9d93ca12738c4c7911000c
git cherry-pick 97597a39778eefb628eb7734a18f32c7880ad0e0

At this point, the dcon functionality is still working.

Now we apply the commit that broke XO-1.5 video display:

git cherry-pick fd3cc69848b7e1873e5f12bbcdd57
[dcon-test3 c8f0551] viafb: remove duplicated clock storage
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 5 files changed, 133 insertions(+), 212 deletions(-)
2b20277ecf3

As expected, the system now boots without working display. So we jump
ahead and grab the fix for that from v3.0:

git cherry-pick b4ce6a285b65be4fb858728b3bbe9011242b769f
[dcon-test3 158fa27] viafb: fix OLPC DCON refresh rate
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 2 files changed, 7 insertions(+), 3 deletions(-)

Regular viafb operation and DCON freeze both work fine at this point.

However, the commit that follows the "fix OLPC DCON refresh rate" is
titled "fix OLPC XO 1.5 device connection" and the message suggests
that it is essential for operation. This doesn't seem to be completely
true - things are working fine with this tree without that patch. And
if I apply it:

git cherry-pick 32fab7bcc79ee0b97277627f456c94202858d851
[dcon-test3 3d690a2] viafb: fix OLPC XO 1.5 device connection
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 1 files changed, 5 insertions(+), 0 deletions(-)

Now the DCON freeze problem appears. So commit 32fab7bcc seems to be
in some way responsible or related to this issue. (However, I have
applied it 'out of context' from the original history).

If I revert this commit from linus master, the system boots with
bad/unreadable display. So in linus master this patch is needed for
the display to come up properly (as the description suggests).



Taking another debugging approach: I start at 2.6.39 (which has
working DCON driver) and apply the OLPC display fix:

git reset --hard v2.6.39
git cherry-pick b4ce6a285b65be4fb858728b3bbe9011242b769f
[dcon-test3 8f8b430] viafb: fix OLPC DCON refresh rate
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 2 files changed, 7 insertions(+), 3 deletions(-)

Regular operation and DCON freeze both work fine at this point.

Now I take the first post-2.6.39 viafb commit:

git cherry-pick 0f8132b7431e241c29e61ac14f22549a6fca9632
[dcon-test3 b66cc33] viafb: move initialization code
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 1 files changed, 7 insertions(+), 5 deletions(-)

Regular operation and DCON freeze continue to work fine.


git cherry-pick 486d4c08dd2eb29b26b4a27f8056155a7a639861
[dcon-test3 e8cfb95] viafb: no need to write CRTC values twice
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 1 files changed, 0 insertions(+), 3 deletions(-)

Now the system boots with bad/unreadable video, so I take an estimated
guess at how to fix it:

git cherry-pick 32fab7bcc79ee0b97277627f456c94202858d851
[dcon-test3 3d690a2] viafb: fix OLPC XO 1.5 device connection
 Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 1 files changed, 5 insertions(+), 0 deletions(-)

Now the system boots with a readable display, but the DCON bug now
appears. So 486d4c08d also seems to be responsible or related to the
DCON issue in question.



I next tried to revert (only) 486d4c08d from linus master, but this
patch does not revert cleanly:
drivers/video/via/hw.c: In function 'hw_init':
drivers/video/via/hw.c:1827:25: error: 'crt_timing' undeclared (first
use in this function)
drivers/video/via/hw.c:1827:25: note: each undeclared identifier is
reported only once for each function it appears in
drivers/video/via/hw.c:1827:37: error: 'vmode_tbl' undeclared (first
use in this function)
drivers/video/via/hw.c:1827:48: error: 'video_bpp' undeclared (first
use in this function)
drivers/video/via/hw.c:1827:2: error: too many arguments to function
'viafb_fill_crtc_timing'
drivers/video/via/hw.c:1489:6: note: declared here

So here is where I am a bit stuck.
My suspicion is that 486d4c08d is needed (for some reason), and in its
presence, I suspect that 32fab7bc is not needed, and that DCON freeze
will then work under this configuration.


A further data point on this issue: we once hit exactly the same thing
on XO-1 (geode lxfb). A non-OLPC commit caused the v/h sync output
polarity to change. The display still worked correctly, but the DCON
freeze functionality caused garbage in exactly the same way as this
viafb issue. This suggests that the display itself isn't too fussy
about video signal parameters, but the DCON controller is picky and
expects certain parameters. (see commit ad913da61aeb for the lxfb
fix).

Any thoughts?

Thanks,
Daniel

From: "Andrew Wade" <andrew.j.wade@gmail.com>
Subject: Re: 2.6.19-rc4-mm2
Date: Mon, 6 Nov 2006 23:31:10 -0500
Message-ID: <610823610611062031m5dd3f258xe1c296d5794427f3@mail.gmail.com>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A04A@EXNA.corp.stratus.com>
Reply-To: ajwade@alumni.uwaterloo.ca
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754002AbWKGEbM@vger.kernel.org>
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A04A@EXNA.corp.stratus.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com> wrote:
...
> How much is each line offset when you have the garbled stuff? I mean,
> is it a couple pixels, half the total width, something else? And is
> it always the same for each line (or can you tell)?

Each ghost is 1/3 of a screen horizontally from the other ghosts. I've
been looking carefully at test patterns to figure out what is going on.

If

(1,1) (2,1) (3,1) (4,1) (5,1) (6,1) (7,1) (8,1)
(1,2) (2,2) (3,2) (4,2) (5,2) (6,2) (7,2) (8,2)
(1,3) (2,3) (3,3) (4,3) (5,3) (6,3) (7,3) (8,3)
(1,4) (2,4) (3,4) (4,4) (5,4) (6,4) (7,4) (8,4)
(1,5) (2,5) (3,5) (4,5) (5,5) (6,5) (7,5) (8,5)
(1,6) (2,6) (3,6) (4,6) (5,6) (6,6) (7,6) (8,6)

is what should be displayed, I'm getting instead

(1,1) (2,1) (3,1) black (4,1) (5,1) (6,1) black
(7,1) (8,1) (1,2) black (2,2) (3,2) (4,2) black
(5,2) (6,2) (7,2) black (8,2) (1,3) (2,3) black
(3,3) (4,3) (5,3) black (6,3) (7,3) (8,3) black
(1,4) (2,4) (3,4) black (4,4) (5,4) (6,4) black
(7,4) (8,4) (1,5) black (2,5) (3,5) (4,5) black

i.e., a black pixel is inserted every thee pixels.

However, it's not just a garbled display, the acceleration (I think) is
also bogus. When I tried setting a solid colour using echo -e '\e[47m',
instead of the above display, I got

(1,1) (2,1) (3,1) black (4,1) black black black
black black (1,2) black (2,2) (3,2) (4,2) black
black black black black black (1,3) (2,3) black
(3,3) (4,3) black black black black black black
(1,4) (2,4) (3,4) black (4,4) black black black
black black (1,5) black (2,5) (3,5) (4,5) black

i.e., in addition to a black pixel being inserted every three pixels,
one of the halves of the "source" image is black. And in the X virtual
console, the cursor is ungarbled.

Two other thing of note is that virtual consoles 2-6 are garbled after
only some boots. (vc7, the X server console, is always garbled). And
output below the as-displayed bottom of a garbled virtual console
prevents me from switching to a different vc. (I get "radeonfb FIFO
Timeout !"/"radeonfb Idle Timeout !" on the serial line).

Hope this helps,

ajw

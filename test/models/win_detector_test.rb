require 'test_helper'

class WinDetectorTest < ActiveSupport::TestCase
  def test_winning_hands
    m_123456789 = (1..9).each_slice(3).map {|seq| seq.map {|i| WinDetector::Man.new(number: i) } }
    d_ccc = [] << 3.times.map { WinDetector::Chun.new }
    syabo = Set.new([
      WinDetector::Hand.new(head: WinDetector::East.new, tiles: [], sequences: m_123456789, triplets: d_ccc)
    ])

    assert { WinDetector.build_from_string('123456789mEEwRRRd').winning_hands == syabo }

    m_123 = [WinDetector::Man.new(number: 1), WinDetector::Man.new(number: 2), WinDetector::Man.new(number: 3)]
    m_234 = [WinDetector::Man.new(number: 2), WinDetector::Man.new(number: 3), WinDetector::Man.new(number: 4)]
    p_123 = [WinDetector::Pin.new(number: 1), WinDetector::Pin.new(number: 2), WinDetector::Pin.new(number: 3)]
    s_123 = [WinDetector::Sou.new(number: 1), WinDetector::Sou.new(number: 2), WinDetector::Sou.new(number: 3)]
    renzokukei = Set.new([
      WinDetector::Hand.new(head: WinDetector::Man.new(number: 1), tiles: [], sequences: [m_234, m_234, p_123, s_123], triplets: []),
      WinDetector::Hand.new(head: WinDetector::Man.new(number: 4), tiles: [], sequences: [m_123, m_123, p_123, s_123], triplets: [])
    ])

    assert { WinDetector.build_from_string('11223344m123p123s').winning_hands == renzokukei }
  end

  def test_win?
    assert { WinDetector.build_from_string('123456789mEEwRRRd').win? == true }
    assert { WinDetector.build_from_string('123456788mEEwRRRd').win? == false }
  end
end
